import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/keys/list/controller.dart';
import 'package:flyssh/screens/keys/list/widgets/key_card.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class KeyListView extends StatefulWidget {
  const KeyListView({super.key});

  @override
  State<KeyListView> createState() => _KeyListViewState();
}

class _KeyListViewState extends State<KeyListView> {
  final KeyListController controller = getIt<KeyListController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    controller.loadKeys();
  }

  void _onChanged() {
    final error = controller.error;
    setState(() {});
    if (error != null) {
      controller.clearError();
      toastification.show(
        title: Text(error),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    super.dispose();
  }

  Future<void> _navigateToCreate() async {
    await context.push('/keys/create');
    controller.loadKeys();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "SSH Keys",
      actions: PlatformHelper.isDesktop
          ? [
              FButton(
                variant: FButtonVariant.ghost,
                size: FButtonSizeVariant.sm,
                onPress: _navigateToCreate,
                prefix: const Icon(Icons.add),
                child: const Text("New Key"),
              ),
            ]
          : null,
      floatingActionButton: PlatformHelper.isDesktop
          ? null
          : FloatingActionButton(
              onPressed: _navigateToCreate,
              child: Icon(Icons.add),
            ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.keys.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.vpn_key_outlined,
                        size: 64,
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(height: BASE_SPACE * 2),
                      Text(
                        "No SSH keys yet",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: BASE_SPACE),
                      Text(
                        PlatformHelper.isDesktop
                            ? "Click 'New Key' to add your first key"
                            : "Tap + to add your first key",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: controller.loadKeys,
                  child: PlatformHelper.isDesktop
                      ? _buildGrid(context)
                      : _buildList(context),
                ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(BASE_SPACE * 2),
      itemCount: controller.keys.length,
      itemBuilder: (context, index) {
        final key = controller.keys[index];
        return KeyCard(
          sshKey: key,
          onTap: () {
            context.push('/keys/${key.id}');
          },
          onDelete: () {
            controller.deleteKey(key.id.toString());
          },
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = 320.0;
        final crossAxisCount =
            (constraints.maxWidth / cardWidth).floor().clamp(2, 5);
        final itemWidth =
            (constraints.maxWidth - BASE_SPACE * 2 * (crossAxisCount + 1)) /
                crossAxisCount;

        return SingleChildScrollView(
          padding: EdgeInsets.all(BASE_SPACE * 2),
          child: Wrap(
            spacing: BASE_SPACE * 2,
            runSpacing: BASE_SPACE * 2,
            children: controller.keys.map((key) {
              return SizedBox(
                width: itemWidth,
                child: KeyCard(
                  sshKey: key,
                  onTap: () {
                    context.push('/keys/${key.id}');
                  },
                  onDelete: () {
                    controller.deleteKey(key.id.toString());
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
