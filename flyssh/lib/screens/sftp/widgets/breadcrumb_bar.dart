import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';

class BreadcrumbBar extends StatelessWidget {
  final String path;
  final ValueChanged<String> onNavigate;

  const BreadcrumbBar({
    super.key,
    required this.path,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final parts = path.split('/').where((p) => p.isNotEmpty).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: BASE_SPACE * 2,
        vertical: BASE_SPACE,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () => onNavigate('/'),
              child: Icon(Icons.home, size: 18),
            ),
            if (parts.isNotEmpty)
              Icon(Icons.chevron_right, size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ...parts.asMap().entries.map((entry) {
              final index = entry.key;
              final part = entry.value;
              final fullPath = '/${parts.sublist(0, index + 1).join('/')}';
              final isLast = index == parts.length - 1;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: isLast ? null : () => onNavigate(fullPath),
                    child: Text(
                      part,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isLast
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                            fontWeight:
                                isLast ? FontWeight.w600 : FontWeight.normal,
                          ),
                    ),
                  ),
                  if (!isLast)
                    Icon(Icons.chevron_right, size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
