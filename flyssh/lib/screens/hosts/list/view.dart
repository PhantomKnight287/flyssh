import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/hosts/list/controller.dart';
import 'package:flyssh/screens/hosts/list/widgets/host_card.dart';
import 'package:flyssh/services/os_detection.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class HostListView extends StatefulWidget {
  const HostListView({super.key});

  @override
  State<HostListView> createState() => _HostListViewState();
}

class _HostListViewState extends State<HostListView> {
  final HostListController controller = getIt<HostListController>();
  final OsDetectionService osDetectionService =
      getIt<OsDetectionService>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    osDetectionService.addListener(_onOsChanged);
    controller.loadHosts();
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

  void _onOsChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    osDetectionService.removeListener(_onOsChanged);
    super.dispose();
  }

  Future<void> _navigateToCreate() async {
    await context.push('/hosts/create');
    controller.loadHosts();
  }

  Widget _buildHostCard(dynamic host) {
    final osInfo =
        osDetectionService.getCachedOsInfo(host.id.toString());
    return HostCard(
      host: host,
      osInfo: osInfo,
      onTap: () {
        context.push('/hosts/${host.id}');
      },
      onDelete: () {
        controller.deleteHost(host.id.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "Hosts",
      actions: PlatformHelper.isDesktop
          ? [
              FButton(
                variant: FButtonVariant.ghost,
                size: FButtonSizeVariant.sm,
                onPress: _navigateToCreate,
                prefix: const Icon(Icons.add),
                child: const Text("New Host"),
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
          : controller.hosts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.dns_outlined,
                        size: 64,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                      SizedBox(height: BASE_SPACE * 2),
                      Text(
                        "No hosts yet",
                        style:
                            Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: BASE_SPACE),
                      Text(
                        PlatformHelper.isDesktop
                            ? "Click 'New Host' to add your first host"
                            : "Tap + to add your first host",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: controller.loadHosts,
                  child: PlatformHelper.isDesktop
                      ? _buildGrid(context)
                      : _buildList(context),
                ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(BASE_SPACE * 2),
      itemCount: controller.hosts.length,
      itemBuilder: (context, index) =>
          _buildHostCard(controller.hosts[index]),
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
            children: controller.hosts.map((host) {
              return SizedBox(
                width: itemWidth,
                child: _buildHostCard(host),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
