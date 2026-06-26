import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/ssh_session.dart';

class SessionTabBar extends StatelessWidget {
  final Map<String, SshSession> sessions;
  final String? activeSessionId;
  final ValueChanged<String> onSessionSelected;
  final ValueChanged<String> onSessionClosed;

  const SessionTabBar({
    super.key,
    required this.sessions,
    required this.activeSessionId,
    required this.onSessionSelected,
    required this.onSessionClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final entry = sessions.entries.elementAt(index);
          final session = entry.value;
          final isActive = entry.key == activeSessionId;

          return GestureDetector(
            onTap: () => onSessionSelected(entry.key),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: BASE_SPACE * 3),
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.surface
                    : null,
                border: isActive
                    ? Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _statusIcon(session.status),
                    size: 12,
                    color: _statusColor(context, session.status),
                  ),
                  SizedBox(width: BASE_SPACE),
                  Text(
                    session.label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: isActive
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  SizedBox(width: BASE_SPACE),
                  Material(
                    child: InkWell(
                      onTap: () => onSessionClosed(entry.key),
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _statusIcon(SshConnectionStatus status) {
    switch (status) {
      case SshConnectionStatus.connecting:
        return Icons.hourglass_top;
      case SshConnectionStatus.connected:
        return Icons.circle;
      case SshConnectionStatus.disconnected:
        return Icons.circle_outlined;
      case SshConnectionStatus.error:
        return Icons.error;
    }
  }

  Color _statusColor(BuildContext context, SshConnectionStatus status) {
    switch (status) {
      case SshConnectionStatus.connecting:
        return Theme.of(context).colorScheme.primary;
      case SshConnectionStatus.connected:
        return Colors.green;
      case SshConnectionStatus.disconnected:
        return Theme.of(context).colorScheme.onSurfaceVariant;
      case SshConnectionStatus.error:
        return Theme.of(context).colorScheme.error;
    }
  }
}
