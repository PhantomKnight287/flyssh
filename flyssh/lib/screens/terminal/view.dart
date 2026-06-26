import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/services/ssh.dart';
import 'package:flyssh/screens/terminal/widgets/session_tab_bar.dart';
import 'package:flyssh/screens/terminal/widgets/terminal_widget.dart';
import 'package:flyssh/screens/terminal/widgets/empty_terminal.dart';
import 'package:flyssh/screens/terminal/widgets/modifier_keys_bar.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:go_router/go_router.dart';

class TerminalView extends StatefulWidget {
  const TerminalView({super.key});

  @override
  State<TerminalView> createState() => _TerminalViewState();
}

class _TerminalViewState extends State<TerminalView> {
  final SshSessionManager _sessionManager = getIt<SshSessionManager>();
  bool _ctrlActive = false;
  bool _altActive = false;

  // Keep track of original onOutput per session so we can restore on dispose
  final Map<String, void Function(String)?> _originalOnOutputs = {};
  String? _hookedSessionId;

  @override
  void initState() {
    super.initState();
    _sessionManager.addListener(_onSessionChanged);
  }

  void _onSessionChanged() {
    _hookOutputIfNeeded();
    setState(() {});
  }

  void _hookOutputIfNeeded() {
    final session = _sessionManager.activeSession;
    if (session == null || !PlatformHelper.isMobile) return;
    if (_hookedSessionId == session.id) return;

    // Save original onOutput for this session
    _originalOnOutputs.putIfAbsent(session.id, () => session.terminal.onOutput);
    _hookedSessionId = session.id;

    // Replace with our interceptor
    session.terminal.onOutput = (data) {
      final originalOnOutput = _originalOnOutputs[session.id];
      if (_ctrlActive && data.isNotEmpty) {
        final buffer = StringBuffer();
        for (final char in data.codeUnits) {
          if (char >= 0x61 && char <= 0x7A) {
            buffer.writeCharCode(char - 0x60);
          } else if (char >= 0x41 && char <= 0x5A) {
            buffer.writeCharCode(char - 0x40);
          } else {
            buffer.writeCharCode(char);
          }
        }
        originalOnOutput?.call(buffer.toString());
        setState(() => _ctrlActive = false);
      } else if (_altActive && data.isNotEmpty) {
        originalOnOutput?.call('\x1b$data');
        setState(() => _altActive = false);
      } else {
        originalOnOutput?.call(data);
      }
    };
  }

  void _onCtrlToggle() {
    setState(() => _ctrlActive = !_ctrlActive);
  }

  void _onAltToggle() {
    setState(() => _altActive = !_altActive);
  }

  @override
  void dispose() {
    // Restore original onOutput for all hooked sessions
    for (final entry in _originalOnOutputs.entries) {
      final session = _sessionManager.sessions[entry.key];
      if (session != null && entry.value != null) {
        session.terminal.onOutput = entry.value;
      }
    }
    _originalOnOutputs.clear();
    _sessionManager.removeListener(_onSessionChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessions = _sessionManager.sessions;
    final activeSession = _sessionManager.activeSession;

    if (sessions.isEmpty) {
      return const EmptyTerminal();
    }

    // Ensure hook is set up for current session
    _hookOutputIfNeeded();

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SessionTabBar(
                  sessions: sessions,
                  activeSessionId: _sessionManager.activeSessionId,
                  onSessionSelected: (id) =>
                      _sessionManager.setActiveSession(id),
                  onSessionClosed: (id) => _sessionManager.disconnect(id),
                ),
              ),
              if (activeSession != null)
                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 20),
                  tooltip: 'Port Forwarding',
                  onPressed: () => context
                      .push('/port-forward/${activeSession.id}'),
                  padding: EdgeInsets.symmetric(horizontal: BASE_SPACE * 2),
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: BASE_SPACE),
              child: activeSession != null
                  ? TerminalWidget(session: activeSession)
                  : const EmptyTerminal(),
            ),
          ),
          if (PlatformHelper.isMobile && activeSession != null)
            ModifierKeysBar(
              terminal: activeSession.terminal,
              ctrlActive: _ctrlActive,
              altActive: _altActive,
              onCtrlToggle: _onCtrlToggle,
              onAltToggle: _onAltToggle,
            ),
        ],
      ),
    );
  }
}
