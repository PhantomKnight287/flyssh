import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/port_forward.dart';

class ForwardCard extends StatelessWidget {
  final PortForward forward;
  final VoidCallback onDelete;

  const ForwardCard({super.key, required this.forward, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isLocal = forward.type == PortForwardType.local;
    final statusColor = switch (forward.status) {
      PortForwardStatus.active => Colors.green,
      PortForwardStatus.stopped => Theme.of(
        context,
      ).colorScheme.onSurfaceVariant,
      PortForwardStatus.error => Theme.of(context).colorScheme.error,
    };

    return Padding(
      padding: EdgeInsets.only(bottom: BASE_SPACE * 2),
      child: FCard.raw(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: BASE_SPACE * 3,
            vertical: BASE_SPACE * 2.5,
          ),
          child: Row(
            children: [
              Icon(
                isLocal ? Icons.arrow_forward : Icons.arrow_back,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: BASE_SPACE * 3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          isLocal ? 'LOCAL' : 'REMOTE',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        SizedBox(width: BASE_SPACE * 2),
                        Icon(Icons.circle, size: 7, color: statusColor),
                        SizedBox(width: BASE_SPACE),
                        Text(
                          forward.status.name,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: statusColor),
                        ),
                      ],
                    ),
                    SizedBox(height: BASE_SPACE / 2),
                    Text(
                      '${forward.displayBind}  \u2192  ${forward.displayTarget}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                    ),
                    if (forward.errorMessage != null) ...[
                      SizedBox(height: BASE_SPACE / 2),
                      Text(
                        forward.errorMessage!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: BASE_SPACE * 2),
              FButton.icon(
                variant: FButtonVariant.ghost,
                size: FButtonSizeVariant.sm,
                onPress: onDelete,
                child: const Icon(Icons.delete_outline, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
