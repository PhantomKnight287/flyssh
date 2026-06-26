import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/widgets/confirm_dialog.dart';
import 'package:flyssh_api/flyssh_api.dart';

class KeyCard extends StatelessWidget {
  final KeysKeyResponse sshKey;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const KeyCard({
    super.key,
    required this.sshKey,
    required this.onTap,
    required this.onDelete,
  });

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatSubtitle() {
    if (sshKey.createdAt == null) return "SSH Key";
    final date = DateTime.tryParse(sshKey.createdAt!);
    if (date == null) return "SSH Key";
    return "Added ${_months[date.month - 1]} ${date.day}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(BASE_SPACE * 2.5);

    final card = FCard.raw(
      child: ClipRRect(
        borderRadius: radius,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: BASE_SPACE * 3,
                vertical: BASE_SPACE * 2.5,
              ),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(BASE_SPACE * 2),
                    ),
                    child: Icon(
                      Icons.vpn_key_outlined,
                      size: 18,
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(width: BASE_SPACE * 3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          sshKey.label ?? 'Unnamed Key',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: BASE_SPACE / 2),
                        Text(
                          _formatSubtitle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: BASE_SPACE * 2),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Dismissible(
      key: ValueKey(sshKey.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: BASE_SPACE * 4),
        decoration: BoxDecoration(
          color: colors.error,
          borderRadius: BorderRadius.circular(BASE_SPACE * 2.5),
        ),
        child: Icon(Icons.delete, color: colors.onError),
      ),
      confirmDismiss: (direction) async {
        return await showConfirmDialog(
          context: context,
          title: "Delete Key",
          message: "Are you sure you want to delete ${sshKey.label}?",
        );
      },
      onDismissed: (_) => onDelete(),
      child: Padding(
        padding: EdgeInsets.only(bottom: BASE_SPACE * 2),
        child: card,
      ),
    );
  }
}
