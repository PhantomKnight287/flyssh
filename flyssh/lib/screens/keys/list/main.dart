import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/keys/create/presentation/main.dart';
import 'package:flyssh/screens/keys/service/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flyssh/utils/error.dart';
import 'package:flyssh/utils/string.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart';

class KeysList extends StatefulWidget {
  const KeysList({
    super.key,
    required this.pagingController,
  });
  final PagingController<int, PartialKey> pagingController;

  @override
  State<KeysList> createState() => _KeysListState();
}

class _KeysListState extends State<KeysList> {
  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await KeysService.getKeys(
        pageKey,
      );

      final items = newItems.toList();
      final isLastPage = items.length < PAGE_SIZE;
      if (isLastPage) {
        widget.pagingController.appendLastPage(
          items,
        );
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(
          items,
          nextPageKey,
        );
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // No need of Scaffold as we're already rendering it inside a page
    return Row(
      children: [
        Expanded(
          child: isPhone()
              ? PagedListView<int, PartialKey>(
                  pagingController: widget.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PartialKey>(
                    itemBuilder: (context, sshKey, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: KeyItem(
                        sshKey: sshKey,
                        pagingController: widget.pagingController,
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) {
                      return const Center(
                        child: Text(
                          "No hosts found, add one",
                        ),
                      );
                    },
                  ),
                )
              : LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final crossAxisCount = width < 600
                      ? 2 // Mobile screens
                      : width < 900
                          ? 3 // Tablet/smaller desktop
                          : width < 1200
                              ? 4 // Desktop
                              : 5;
                  return PagedGridView(
                    pagingController: widget.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<PartialKey>(
                      itemBuilder: (context, sshKey, index) => KeyItem(
                        sshKey: sshKey,
                        pagingController: widget.pagingController,
                      ),
                      noItemsFoundIndicatorBuilder: (context) {
                        return const Center(
                          child: Text(
                            "No hosts found, add one",
                          ),
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: 70,
                    ),
                  );
                }),
        ),
      ],
    );
  }
}

class KeyItem extends StatefulWidget {
  final PartialKey sshKey;
  final PagingController<int, PartialKey> pagingController;
  const KeyItem({
    super.key,
    required this.sshKey,
    required this.pagingController,
  });

  @override
  State<KeyItem> createState() => _KeyItemState();
}

class _KeyItemState extends State<KeyItem> {
  late List<ContextMenuEntry> _entries;

  void _showDeleteConfirmationModalAndDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text("Are you sure you want to delete ${widget.sshKey.label}?"),
          content: const Text("This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isPhone()) {
                  Navigator.of(context).pop(); // close the sheet as well
                }
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await HapticFeedback.heavyImpact();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  if (isPhone()) {
                    Navigator.of(context).pop(); // close the sheet as well
                  }
                  try {
                    await KeysService.deleteKey(widget.sshKey.id);
                    showSuccessToast(
                      title: "Key deleted successfully",
                    );
                    widget.pagingController.refresh();
                  } catch (e) {
                    showErrorToast(e);
                  }
                }
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _entries = [
      MenuItem(
        label: 'Edit',
        icon: Icons.edit,
        onSelected: () {
          if (isPhone()) Navigator.pop(context);
          Navigator.of(context).push(
            CustomCupertinoRoute(
              builder: (context) {
                return CreateKeyScreen(
                  sshKey: widget.sshKey,
                );
              },
            ),
          ).then(
            (value) {
              widget.pagingController.refresh();
            },
          );
        },
      ),
      MenuItem(
        label: 'Delete',
        icon: Icons.delete,
        onSelected: _showDeleteConfirmationModalAndDelete,
      ),
    ];
  }

  ContextMenu contextMenu(BuildContext context) {
    return ContextMenu(
      entries: _entries,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isPhone()) {
      return _buildItem(
        context,
        showLongPressSheet: true,
      );
    }
    return ContextMenuRegion(
      contextMenu: contextMenu(context),
      child: _buildItem(context),
    );
  }

  ListTile _buildItem(
    BuildContext context, {
    bool showLongPressSheet = false,
  }) {
    return ListTile(
      onLongPress: showLongPressSheet
          ? () async {
              await HapticFeedback.selectionClick();
              if (context.mounted) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 250,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildItem(context),
                          ),
                          ListTile(
                            title: const Text("Edit"),
                            leading: const Icon(
                              Icons.edit,
                            ),
                            onTap: () {
                              if (isPhone()) Navigator.pop(context);
                              Navigator.of(context).push(
                                CustomCupertinoRoute(
                                  builder: (context) {
                                    return CreateKeyScreen(
                                      sshKey: widget.sshKey,
                                    );
                                  },
                                ),
                              ).then(
                                (value) {
                                  widget.pagingController.refresh();
                                },
                              );
                            },
                          ),
                          ListTile(
                            title: const Text("Delete"),
                            leading: const Icon(
                              Icons.delete,
                            ),
                            onTap: _showDeleteConfirmationModalAndDelete,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
          : null,
      title: Text(
        widget.sshKey.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      subtitle: Text(
        "Used by ${widget.sshKey.count.hosts} ${pluralize(widget.sshKey.count.hosts, "host")}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      enabled: true,
      leading: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          padding: const EdgeInsets.all(4),
          child: const Icon(
            Icons.key,
          ),
        ),
      ),
    );
  }
}
