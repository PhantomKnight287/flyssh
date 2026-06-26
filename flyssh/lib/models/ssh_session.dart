import 'package:dartssh2/dartssh2.dart';
import 'package:flyssh/models/port_forward.dart';
import 'package:flyssh/services/os_detection.dart';
import 'package:xterm/xterm.dart';

enum SshConnectionStatus {
  connecting,
  connected,
  disconnected,
  error,
}

class SshSession {
  final String id;
  final String label;
  final String hostname;
  final int port;
  final String username;
  final String? hostId;
  SSHClient? client;
  SSHSession? shellSession;
  Terminal terminal;
  SshConnectionStatus status;
  String? errorMessage;
  OsInfo? osInfo;
  final List<PortForward> portForwards = [];

  SshSession({
    required this.id,
    required this.label,
    required this.hostname,
    required this.port,
    required this.username,
    this.hostId,
    this.client,
    this.shellSession,
    Terminal? terminal,
    this.status = SshConnectionStatus.connecting,
    this.errorMessage,
    this.osInfo,
  }) : terminal = terminal ?? Terminal(maxLines: 10000);
}
