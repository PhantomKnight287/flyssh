import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/hosts/detail/controller.dart';
import 'package:flyssh/screens/keys/service.dart';
import 'package:flyssh/services/os_detection.dart';
import 'package:flyssh/services/ssh.dart';
import 'package:flyssh/widgets/confirm_dialog.dart';
import 'package:flyssh/widgets/os_icon.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class HostDetailView extends StatefulWidget {
  final String hostId;

  const HostDetailView({super.key, required this.hostId});

  @override
  State<HostDetailView> createState() => _HostDetailViewState();
}

class _HostDetailViewState extends State<HostDetailView> {
  final HostDetailController controller = getIt<HostDetailController>();
  final SshSessionManager sessionManager = getIt<SshSessionManager>();
  final OsDetectionService osDetectionService = getIt<OsDetectionService>();
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    osDetectionService.addListener(_onOsChanged);
    controller.loadHost(widget.hostId);
  }

  void _onChanged() {
    setState(() {});
    if (controller.deleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pop();
      });
    }
  }

  void _onOsChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    osDetectionService.removeListener(_onOsChanged);
    super.dispose();
  }

  Future<bool> _connectSsh({bool navigate = true}) async {
    final host = controller.host;
    if (host == null) return false;

    setState(() => _isConnecting = true);
    try {
      final password = await controller.getDecryptedPassword();
      final keyService = getIt<KeyService>();

      if (host.key != null && host.key!.value != null) {
        final decryptedKey = await keyService.decryptValue(
          host.key!.value,
          host.key!.iv,
        );
        final decryptedPassphrase = await keyService.decryptPassphrase(
          host.key!.passphrase,
          host.key!.iv,
        );

        await sessionManager.connectWithKey(
          label: host.label ?? 'SSH',
          hostname: host.hostname ?? '',
          port: host.port ?? 22,
          username: host.username ?? '',
          privateKey: decryptedKey ?? '',
          passphrase: decryptedPassphrase,
          hostId: widget.hostId,
        );
      } else if (password != null && password.isNotEmpty) {
        await sessionManager.connectWithPassword(
          label: host.label ?? 'SSH',
          hostname: host.hostname ?? '',
          port: host.port ?? 22,
          username: host.username ?? '',
          password: password,
          hostId: widget.hostId,
        );
      } else {
        toastification.show(
          title: Text("No authentication method available"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
        setState(() => _isConnecting = false);
        return false;
      }

      if (mounted && navigate) {
        context.go('/terminal');
      }
      setState(() => _isConnecting = false);
      return true;
    } catch (e) {
      if (mounted) {
        toastification.show(
          title: Text("Connection failed"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
          description: Text(e.toString()),
        );
      }
      setState(() => _isConnecting = false);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return PageScaffold(
        title: "Host",
        showBackButton: true,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final host = controller.host;
    if (host == null) {
      return PageScaffold(
        title: "Host",
        showBackButton: true,
        body: Center(child: Text(controller.error ?? "Host not found")),
      );
    }

    final osInfo = osDetectionService.getCachedOsInfo(widget.hostId);

    final connection = _connectionString(host);

    return PageScaffold(
      title: host.label ?? 'Host',
      showBackButton: true,
      maxContentWidth: 700,
      actions: [
        FButton.icon(
          child: const Icon(Icons.edit_outlined),
          onPress: () async {
            await context.push('/hosts/${widget.hostId}/edit');
            controller.loadHost(widget.hostId);
          },
        ),
        FButton.icon(
          child: const Icon(Icons.delete_outline),
          onPress: () async {
            final confirm = await showConfirmDialog(
              context: context,
              title: "Delete Host",
              message: "Are you sure you want to delete ${host.label}?",
            );
            if (confirm == true) {
              controller.deleteHost(widget.hostId);
            }
          },
        ),
      ],
      body: ListView(
        padding: EdgeInsets.all(BASE_SPACE * 4),
        children: [
          _HostHeader(
            title: host.label ?? host.hostname ?? 'Host',
            connection: connection,
            osInfo: osInfo,
          ),
          SizedBox(height: BASE_SPACE * 6),
          const _SectionLabel("Connection"),
          SizedBox(height: BASE_SPACE * 2),
          _InfoCard(
            children: [
              _DetailRow(
                label: "Hostname",
                value: host.hostname ?? '—',
                mono: true,
              ),
              _DetailRow(
                label: "Port",
                value: (host.port ?? 22).toString(),
                mono: true,
              ),
              _DetailRow(
                label: "Username",
                value: host.username ?? '—',
                mono: true,
              ),
              if (host.password != null && host.password!.isNotEmpty)
                const _DetailRow(label: "Password", value: "••••••••"),
              if (host.key != null)
                _DetailRow(
                  label: "SSH Key",
                  value: host.key!.label ?? 'Unnamed',
                  icon: Icons.vpn_key,
                ),
            ],
          ),
          if (osInfo != null) ...[
            SizedBox(height: BASE_SPACE * 6),
            const _SectionLabel("Operating System"),
            SizedBox(height: BASE_SPACE * 2),
            _InfoCard(
              children: [
                _DetailRow(label: "Distribution", value: osInfo.displayName),
                if (osInfo.version != null)
                  _DetailRow(label: "Version", value: osInfo.version!),
              ],
            ),
          ],
          SizedBox(height: BASE_SPACE * 6),
          FButton(
            onPress: _isConnecting ? null : _connectSsh,
            prefix: _isConnecting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.terminal),
            child: Text(_isConnecting ? "Connecting..." : "Connect SSH"),
          ),
          SizedBox(height: BASE_SPACE * 2),
          Row(
            children: [
              Expanded(
                child: FButton(
                  variant: FButtonVariant.outline,
                  onPress: _isConnecting
                      ? null
                      : () async {
                          final success = await _connectSsh(navigate: false);
                          if (!success || !context.mounted) return;
                          final sessionId = sessionManager.activeSessionId;
                          if (sessionId != null) {
                            context.push('/sftp/$sessionId');
                          }
                        },
                  prefix: const Icon(Icons.folder_outlined),
                  child: const Text("SFTP"),
                ),
              ),
              SizedBox(width: BASE_SPACE * 2),
              Expanded(
                child: FButton(
                  variant: FButtonVariant.outline,
                  onPress: _isConnecting
                      ? null
                      : () async {
                          final success = await _connectSsh(navigate: false);
                          if (!success || !context.mounted) return;
                          final sessionId = sessionManager.activeSessionId;
                          if (sessionId != null) {
                            context.push('/port-forward/$sessionId');
                          }
                        },
                  prefix: const Icon(Icons.swap_horiz),
                  child: const Text("Forward"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _connectionString(HostsHostResponse host) {
    final hostname = host.hostname;
    if (hostname == null || hostname.isEmpty) return null;
    final user = host.username;
    final base = (user != null && user.isNotEmpty)
        ? '$user@$hostname'
        : hostname;
    final port = host.port;
    return (port != null && port != 22) ? '$base:$port' : base;
  }
}

class _HostHeader extends StatelessWidget {
  final String title;
  final String? connection;
  final OsInfo? osInfo;

  const _HostHeader({
    required this.title,
    required this.connection,
    required this.osInfo,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        osInfo != null
            ? OsIcon(osId: osInfo!.id, size: 52)
            : Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colors.primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(BASE_SPACE * 3),
                ),
                child: Icon(
                  Icons.dns_outlined,
                  color: colors.onPrimaryContainer,
                ),
              ),
        SizedBox(width: BASE_SPACE * 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              if (connection != null) ...[
                SizedBox(height: BASE_SPACE / 2),
                Text(
                  connection!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: BASE_SPACE),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      height: 1,
      color: Theme.of(
        context,
      ).colorScheme.outlineVariant.withValues(alpha: 0.5),
    );

    return FCard.raw(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: BASE_SPACE * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < children.length; i++) ...[
              if (i > 0) divider,
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool mono;
  final IconData? icon;

  const _DetailRow({
    required this.label,
    required this.value,
    this.mono = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: BASE_SPACE * 2.5),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
          ),
          SizedBox(width: BASE_SPACE * 4),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 14, color: colors.primary),
                  SizedBox(width: BASE_SPACE),
                ],
                Flexible(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: mono ? 'monospace' : null,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
