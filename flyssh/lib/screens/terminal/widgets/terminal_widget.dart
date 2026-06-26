import 'package:flutter/material.dart';
import 'package:flyssh/models/ssh_session.dart';
import 'package:flyssh/theme/terminal_theme.dart';
import 'package:xterm/xterm.dart' hide TerminalTheme, TerminalThemes;

class TerminalWidget extends StatelessWidget {
  final SshSession session;

  const TerminalWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    if (session.status == SshConnectionStatus.error) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 8),
            Text(
              "Connection error",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 4),
            Text(
              session.errorMessage ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (session.status == SshConnectionStatus.connecting) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Connecting to ${session.hostname}...",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return TerminalView(
      session.terminal,
      theme: TerminalThemes.fromContext(context),
      autofocus: true,
    );
  }
}
