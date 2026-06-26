import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/keys/detail/controller.dart';
import 'package:flyssh/widgets/confirm_dialog.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';

class KeyDetailView extends StatefulWidget {
  final String keyId;

  const KeyDetailView({super.key, required this.keyId});

  @override
  State<KeyDetailView> createState() => _KeyDetailViewState();
}

String _formatDate(String iso) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  final date = DateTime.tryParse(iso);
  if (date == null) return iso;
  return "${months[date.month - 1]} ${date.day}, ${date.year}";
}

class _KeyDetailViewState extends State<KeyDetailView> {
  final KeyDetailController controller = getIt<KeyDetailController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    controller.loadKey(widget.keyId);
  }

  void _onChanged() {
    setState(() {});
    if (controller.deleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pop();
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return PageScaffold(
        title: "SSH Key",
        showBackButton: true,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final sshKey = controller.sshKey;
    if (sshKey == null) {
      return PageScaffold(
        title: "SSH Key",
        showBackButton: true,
        body: Center(child: Text(controller.error ?? "Key not found")),
      );
    }

    return PageScaffold(
      title: sshKey.label ?? 'SSH Key',
      showBackButton: true,
      maxContentWidth: 600,
      actions: [
        FHeaderAction(
          icon: Icon(Icons.edit),
          onPress: () async {
            await context.push('/keys/${widget.keyId}/edit');
            controller.loadKey(widget.keyId);
          },
        ),
        FHeaderAction(
          icon: Icon(Icons.delete),
          onPress: () async {
            final confirm = await showConfirmDialog(
              context: context,
              title: "Delete Key",
              message: "Are you sure you want to delete ${sshKey.label}?",
            );
            if (confirm == true) {
              controller.deleteKey(widget.keyId);
            }
          },
        ),
      ],
      body: ListView(
        padding: EdgeInsets.all(BASE_SPACE * 4),
        children: [
          FCard(
            child: Padding(
              padding: EdgeInsets.all(BASE_SPACE * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(label: "Label", value: sshKey.label ?? ''),
                  _DetailRow(
                    label: "Has Passphrase",
                    value: (sshKey.passphrase != null &&
                            sshKey.passphrase!.isNotEmpty)
                        ? "Yes"
                        : "No",
                  ),
                  if (sshKey.createdAt != null)
                    _DetailRow(
                        label: "Created", value: _formatDate(sshKey.createdAt!)),
                  if (sshKey.updatedAt != null)
                    _DetailRow(
                        label: "Updated", value: _formatDate(sshKey.updatedAt!)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: BASE_SPACE),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
