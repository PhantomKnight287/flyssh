import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/services/os_detection.dart';
import 'package:flyssh/widgets/confirm_dialog.dart';
import 'package:flyssh/widgets/os_icon.dart';
import 'package:flyssh_api/flyssh_api.dart';

class HostCard extends StatelessWidget {
  final HostsHostResponse host;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final OsInfo? osInfo;

  const HostCard({
    super.key,
    required this.host,
    required this.onTap,
    required this.onDelete,
    this.osInfo,
  });

  /// A Termius-style connection descriptor, e.g. `root@10.0.0.1` or
  /// `deploy@example.com:2222`. Falls back to the detected OS name.
  String? _subtitle() {
    final hostname = host.hostname;
    if (hostname != null && hostname.isNotEmpty) {
      final user = host.username;
      final base = (user != null && user.isNotEmpty)
          ? '$user@$hostname'
          : hostname;
      final port = host.port;
      return (port != null && port != 22) ? '$base:$port' : base;
    }
    return osInfo?.displayName;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitle = _subtitle();
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
                  osInfo != null
                      ? OsIcon(osId: osInfo!.id, size: 34)
                      : Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: colors.primaryContainer.withValues(
                              alpha: 0.4,
                            ),
                            borderRadius: BorderRadius.circular(BASE_SPACE * 2),
                          ),
                          child: Icon(
                            Icons.dns_outlined,
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
                          host.label ?? host.hostname ?? 'Unnamed Host',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (subtitle != null) ...[
                          SizedBox(height: BASE_SPACE / 2),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (host.key != null) ...[
                    SizedBox(width: BASE_SPACE * 2),
                    Icon(Icons.vpn_key, size: 14, color: colors.primary),
                  ],
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
      key: ValueKey(host.id),
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
          title: "Delete Host",
          message: "Are you sure you want to delete ${host.label}?",
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
