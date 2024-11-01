import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyssh/components/bottom.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/hosts/create/presentation/main.dart';
import 'package:flyssh/screens/hosts/service/main.dart';
import 'package:flyssh/screens/keys/create/presentation/main.dart';
import 'package:flyssh/screens/keys/list/main.dart';
import 'package:flyssh/screens/ssh/presentation/main.dart';
import 'package:flyssh/themes/terminal.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flyssh/utils/error.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class HostsScreen extends StatefulWidget {
  const HostsScreen({super.key});

  @override
  State<HostsScreen> createState() => _HostsScreenState();
}

class _HostsScreenState extends State<HostsScreen> {
  final PagingController<int, PartialHost> _pagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, PartialKey> _keysPagingController = PagingController(
    firstPageKey: 1,
  );
  int _currentActiveItem = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _setSharedPrefs();
    super.initState();
  }

  Future<void> _setSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await HostsService.getHosts(
        pageKey,
      );

      final items = newItems.toList();
      final isLastPage = items.length < PAGE_SIZE;
      if (isLastPage) {
        _pagingController.appendLastPage(
          items,
        );
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(
          items,
          nextPageKey,
        );
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _showSettingsModal(context) {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (context) {
        return [
          WoltModalSheetPage(
            topBarTitle: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            isTopBarLayerAlwaysVisible: true,
            trailingNavBarWidget: IconButton(
              icon: const Icon(Icons.close),
              onPressed: Navigator.of(context).pop,
            ),
            child: StatefulBuilder(builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.all(
                  16,
                ),
                child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(
                        bottom: BASE_SPACE * 1,
                      ),
                      child: Text(
                        "Theme",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: DropdownButton(
                      value: prefs.getString(
                            "theme",
                          ) ??
                          "default",
                      items: themes
                          .map((e) => DropdownMenuItem(
                                value: e.value,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: (value) async {
                        if (value == null) return;

                        prefs.setString(
                          "theme",
                          value,
                        );
                        setState(() {});
                      },
                    )),
              );
            }),
          )
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPhone()
          ? AppBar(
              title: Text(
                _currentActiveItem == 0 ? "Hosts" : "Keys",
              ),
              centerTitle: false,
              bottom: Bottom(
                context,
              ),
              actions: [
                IconButton(
                  onPressed: () => _showSettingsModal(context),
                  icon: const Icon(
                    Icons.settings_rounded,
                  ),
                )
              ],
            )
          : null,
      body: Padding(
        padding: EdgeInsets.all(
          isPhone() ? 0 : BASE_SPACE * 2,
        ),
        child: Row(
          children: [
            if (!isPhone())
              NavigationRail(
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (value) {
                  setState(() {
                    _currentActiveItem = value;
                  });
                },
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.settings_rounded,
                            ),
                            onPressed: () => _showSettingsModal(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(
                      Icons.terminal_rounded,
                    ),
                    label: Text(
                      "Hosts",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(
                      Icons.key_rounded,
                    ),
                    label: Text(
                      "Keys",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
                selectedIndex: _currentActiveItem,
                leading: ElevatedButton(
                  onPressed: () {
                    if (_currentActiveItem == 0) {
                      Navigator.of(context).push(
                        CustomCupertinoRoute(
                          builder: (context) {
                            return const CreateHostsScreen();
                          },
                        ),
                      ).then(
                        (value) {
                          _pagingController.refresh();
                        },
                      );
                    } else {
                      Navigator.of(context).push(
                        CustomCupertinoRoute(
                          builder: (context) {
                            return const CreateKeyScreen();
                          },
                        ),
                      ).then(
                        (value) {
                          _keysPagingController.refresh();
                        },
                      );
                    }
                  },
                  child: const Icon(
                    Icons.add_rounded,
                  ),
                ),
              ),
            if (!isPhone())
              const VerticalDivider(
                thickness: 1,
                width: 1,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(
                  BASE_SPACE * 3,
                ),
                child: _currentActiveItem == 0
                    ? isPhone()
                        ? PagedListView<int, PartialHost>(
                            pagingController: _pagingController,
                            builderDelegate: PagedChildBuilderDelegate<PartialHost>(
                              itemBuilder: (context, host, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: HostItem(
                                  host: host,
                                  pagingController: _pagingController,
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
                              pagingController: _pagingController,
                              builderDelegate: PagedChildBuilderDelegate<PartialHost>(
                                itemBuilder: (context, host, index) => HostItem(
                                  host: host,
                                  pagingController: _pagingController,
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
                          })
                    : KeysList(
                        pagingController: _keysPagingController,
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isPhone()
          ? FloatingActionButton(
              onPressed: () {
                if (_currentActiveItem == 0) {
                  Navigator.of(context).push(
                    CustomCupertinoRoute(
                      builder: (context) {
                        return const CreateHostsScreen();
                      },
                    ),
                  ).then(
                    (value) {
                      _pagingController.refresh();
                    },
                  );
                } else {
                  Navigator.of(context).push(
                    CustomCupertinoRoute(
                      builder: (context) {
                        return const CreateKeyScreen();
                      },
                    ),
                  ).then(
                    (value) {
                      _keysPagingController.refresh();
                    },
                  );
                }
              },
              child: const Icon(
                Icons.add_rounded,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: isPhone()
          ? NavigationBar(
              selectedIndex: _currentActiveItem,
              onDestinationSelected: (value) {
                setState(() {
                  _currentActiveItem = value;
                });
              },
              backgroundColor: Colors.grey.shade200,
              indicatorColor: Colors.black,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.terminal_rounded,
                    color: _currentActiveItem == 0 ? Colors.white : Colors.black,
                  ),
                  label: "Hosts",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.key_rounded,
                    color: _currentActiveItem == 1 ? Colors.white : Colors.black,
                  ),
                  label: "Keys",
                )
              ],
            )
          : null,
    );
  }
}

class HostItem extends StatefulWidget {
  final PartialHost host;
  const HostItem({
    super.key,
    required this.host,
    required this.pagingController,
  });
  final PagingController<int, PartialHost> pagingController;

  @override
  State<HostItem> createState() => _HostItemState();
}

class _HostItemState extends State<HostItem> {
// define your context menu entries
  late List<ContextMenuEntry> _entries;

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
                return CreateHostsScreen(
                  host: widget.host,
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
    if (isDesktop()) {
      return ContextMenuRegion(
        contextMenu: contextMenu(context),
        child: _buildItem(context),
      );
    }
    return _buildItem(
      context,
      showLongPressSheet: true,
    );
  }

  void _showDeleteConfirmationModalAndDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text("Are you sure you want to delete ${widget.host.label}?"),
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
                    await HostsService.deleteHost(widget.host.id);
                    showSuccessToast(
                      title: "Host deleted successfully",
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
                                    return CreateHostsScreen(
                                      host: widget.host,
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        widget.host.label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      subtitle: Text(
        "username: ${widget.host.username}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      enabled: true,
      onTap: () {
        Navigator.of(context).push(
          CustomCupertinoRoute(
            builder: (context) {
              return SshScreen(id: widget.host.id);
            },
          ),
        );
      },
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
            Icons.terminal,
          ),
        ),
      ),
    );
  }
}
