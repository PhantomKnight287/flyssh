import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/foundation.dart';
import 'package:flyssh/models/port_forward.dart';
import 'package:flyssh/models/ssh_session.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/hosts/service.dart';
import 'package:flyssh/services/os_detection.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Callback type for host key verification UI prompts.
/// Returns true to accept the key, false to reject.
typedef HostKeyVerifyCallback = Future<bool> Function(
    String hostname, int port, String fingerprint, String? knownFingerprint);

@singleton
class SshSessionManager extends ChangeNotifier {
  static const _knownHostsPrefix = 'known_host_';
  static const _connectTimeout = Duration(seconds: 15);

  final OsDetectionService osDetectionService;
  final Map<String, SshSession> _sessions = {};
  String? _activeSessionId;

  /// Set this before connecting to provide UI-level host key prompts.
  HostKeyVerifyCallback? onHostKeyVerify;

  SshSessionManager(this.osDetectionService);

  Map<String, SshSession> get sessions => Map.unmodifiable(_sessions);
  String? get activeSessionId => _activeSessionId;
  SshSession? get activeSession =>
      _activeSessionId != null ? _sessions[_activeSessionId] : null;

  String _generateId() {
    final random = Random.secure();
    final bytes = List.generate(8, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<bool> _verifyHostKey(
      String hostname, int port, Uint8List hostKey) async {
    final fingerprint = base64.encode(hostKey);
    final storageKey = '$_knownHostsPrefix${hostname}:$port';
    final prefs = await SharedPreferences.getInstance();
    final knownFingerprint = prefs.getString(storageKey);

    if (knownFingerprint == fingerprint) return true;

    if (onHostKeyVerify != null) {
      final accepted = await onHostKeyVerify!(
          hostname, port, fingerprint, knownFingerprint);
      if (accepted) {
        await prefs.setString(storageKey, fingerprint);
      }
      return accepted;
    }

    // No callback set — accept and store (first-use trust)
    await prefs.setString(storageKey, fingerprint);
    return true;
  }

  Future<String> connectWithPassword({
    required String label,
    required String hostname,
    required int port,
    required String username,
    required String password,
    String? hostId,
  }) async {
    final id = _generateId();
    final session = SshSession(
      id: id,
      label: label,
      hostname: hostname,
      port: port,
      username: username,
      hostId: hostId,
    );

    if (hostId != null) {
      session.osInfo = osDetectionService.getCachedOsInfo(hostId);
    }

    _sessions[id] = session;
    _activeSessionId = id;
    notifyListeners();

    try {
      final socket = await SSHSocket.connect(hostname, port,
          timeout: _connectTimeout);
      final client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
        onVerifyHostKey: (type, fingerprint) =>
            _verifyHostKey(hostname, port, fingerprint),
      );
      session.client = client;
      await _startShell(session);
      _detectOsInBackground(session);
      return id;
    } catch (e) {
      session.status = SshConnectionStatus.error;
      session.errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<String> connectWithKey({
    required String label,
    required String hostname,
    required int port,
    required String username,
    required String privateKey,
    String? passphrase,
    String? hostId,
  }) async {
    final id = _generateId();
    final session = SshSession(
      id: id,
      label: label,
      hostname: hostname,
      port: port,
      username: username,
      hostId: hostId,
    );

    if (hostId != null) {
      session.osInfo = osDetectionService.getCachedOsInfo(hostId);
    }

    _sessions[id] = session;
    _activeSessionId = id;
    notifyListeners();

    try {
      final socket = await SSHSocket.connect(hostname, port,
          timeout: _connectTimeout);
      final identities = SSHKeyPair.fromPem(privateKey, passphrase);
      final client = SSHClient(
        socket,
        username: username,
        identities: identities,
        onVerifyHostKey: (type, fingerprint) =>
            _verifyHostKey(hostname, port, fingerprint),
      );
      session.client = client;
      await _startShell(session);
      _detectOsInBackground(session);
      return id;
    } catch (e) {
      session.status = SshConnectionStatus.error;
      session.errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> _startShell(SshSession session) async {
    final shell = await session.client!.shell(
      pty: SSHPtyConfig(width: 80, height: 24),
    );
    session.shellSession = shell;
    session.status = SshConnectionStatus.connected;

    session.terminal.onOutput = (data) {
      shell.write(utf8.encode(data));
    };

    session.terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      shell.resizeTerminal(width, height);
    };

    shell.stdout.listen(
      (data) {
        session.terminal.write(utf8.decode(data, allowMalformed: true));
      },
      onDone: () {
        session.status = SshConnectionStatus.disconnected;
        notifyListeners();
      },
      onError: (e) {
        session.status = SshConnectionStatus.error;
        session.errorMessage = e.toString();
        notifyListeners();
      },
    );

    shell.stderr.listen((data) {
      session.terminal.write(utf8.decode(data, allowMalformed: true));
    });

    notifyListeners();
  }

  void _detectOsInBackground(SshSession session) async {
    if (session.client == null) return;
    final hostId = session.hostId ?? session.id;
    try {
      final info =
          await osDetectionService.detectOs(session.client!, hostId);
      session.osInfo = info;
      notifyListeners();

      // Send OS info to backend (best-effort)
      if (session.hostId != null) {
        try {
          final hostService = getIt<HostService>();
          await hostService.updateHostOs(
            id: session.hostId!,
            osId: info.id,
            osName: info.name,
            osVersion: info.version,
          );
        } catch (_) {}
      }
    } catch (_) {
      // OS detection is best-effort
    }
  }

  void setActiveSession(String id) {
    if (_sessions.containsKey(id)) {
      _activeSessionId = id;
      notifyListeners();
    }
  }

  List<PortForward> getForwards(String sessionId) {
    final session = _sessions[sessionId];
    return session?.portForwards ?? [];
  }

  Future<PortForward> addLocalForward({
    required String sessionId,
    required int localPort,
    required String remoteHost,
    required int remotePort,
    String localHost = 'localhost',
  }) async {
    final session = _sessions[sessionId];
    if (session == null || session.client == null) {
      throw Exception('Session not found or disconnected');
    }

    final id = _generateId();
    final forward = PortForward(
      id: id,
      type: PortForwardType.local,
      bindHost: localHost,
      bindPort: localPort,
      targetHost: remoteHost,
      targetPort: remotePort,
    );

    try {
      final serverSocket = await ServerSocket.bind(
        localHost == 'localhost' ? InternetAddress.loopbackIPv4 : localHost,
        localPort,
      );
      forward.serverSocket = serverSocket;

      final sub = serverSocket.listen((socket) async {
        try {
          final channel = await session.client!.forwardLocal(
            remoteHost,
            remotePort,
          );
          final s1 = socket.listen(
            (data) => channel.sink.add(data),
            onError: (_) {
              channel.close();
              socket.destroy();
            },
            onDone: () => channel.close(),
          );
          final s2 = channel.stream.listen(
            (data) => socket.add(data),
            onError: (_) => socket.destroy(),
            onDone: () => socket.destroy(),
          );
          forward.subscriptions.addAll([s1, s2]);
        } catch (e) {
          socket.destroy();
        }
      });
      forward.subscriptions.add(sub);

      session.portForwards.add(forward);
      notifyListeners();
      return forward;
    } catch (e) {
      forward.status = PortForwardStatus.error;
      forward.errorMessage = e.toString();
      session.portForwards.add(forward);
      notifyListeners();
      rethrow;
    }
  }

  Future<PortForward> addRemoteForward({
    required String sessionId,
    required int remotePort,
    required String localHost,
    required int localPort,
    String remoteHost = '0.0.0.0',
  }) async {
    final session = _sessions[sessionId];
    if (session == null || session.client == null) {
      throw Exception('Session not found or disconnected');
    }

    final id = _generateId();
    final forward = PortForward(
      id: id,
      type: PortForwardType.remote,
      bindHost: remoteHost,
      bindPort: remotePort,
      targetHost: localHost,
      targetPort: localPort,
    );

    try {
      final remoteForward = await session.client!.forwardRemote(
        host: remoteHost,
        port: remotePort,
      );
      if (remoteForward == null) {
        throw Exception('Remote forwarding not supported by server');
      }
      forward.remoteForward = remoteForward;

      final sub = remoteForward.connections.listen((channel) async {
        try {
          final socket = await Socket.connect(localHost, localPort);
          final s1 = channel.stream.listen(
            (data) => socket.add(data),
            onError: (_) => socket.destroy(),
            onDone: () => socket.destroy(),
          );
          final s2 = socket.listen(
            (data) => channel.sink.add(data),
            onError: (_) {
              channel.close();
              socket.destroy();
            },
            onDone: () => channel.close(),
          );
          forward.subscriptions.addAll([s1, s2]);
        } catch (e) {
          channel.close();
        }
      });
      forward.subscriptions.add(sub);

      session.portForwards.add(forward);
      notifyListeners();
      return forward;
    } catch (e) {
      forward.status = PortForwardStatus.error;
      forward.errorMessage = e.toString();
      session.portForwards.add(forward);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeForward(String sessionId, String forwardId) async {
    final session = _sessions[sessionId];
    if (session == null) return;

    final forward = session.portForwards
        .where((f) => f.id == forwardId)
        .firstOrNull;
    if (forward == null) return;

    await forward.close();
    session.portForwards.remove(forward);
    notifyListeners();
  }

  Future<void> _closeAllForwards(SshSession session) async {
    for (final forward in session.portForwards) {
      await forward.close();
    }
    session.portForwards.clear();
  }

  Future<void> disconnect(String id) async {
    final session = _sessions[id];
    if (session != null) {
      await _closeAllForwards(session);
      session.shellSession?.close();
      session.client?.close();
      _sessions.remove(id);
      if (_activeSessionId == id) {
        _activeSessionId = _sessions.isNotEmpty ? _sessions.keys.last : null;
      }
      notifyListeners();
    }
  }

  Future<void> disconnectAll() async {
    for (final session in _sessions.values) {
      await _closeAllForwards(session);
      session.shellSession?.close();
      session.client?.close();
    }
    _sessions.clear();
    _activeSessionId = null;
    notifyListeners();
  }
}
