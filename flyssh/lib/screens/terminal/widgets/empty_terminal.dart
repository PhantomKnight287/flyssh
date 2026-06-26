import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';

class EmptyTerminal extends StatelessWidget {
  const EmptyTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.terminal,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: BASE_SPACE * 2),
          Text(
            "No active sessions",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: BASE_SPACE),
          Text(
            "Connect to a host to start a terminal session",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
