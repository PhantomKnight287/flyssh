import 'package:flutter/material.dart';
import 'package:flyssh/components/bottom.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/hosts/create/presentation/main.dart';
import 'package:flyssh/screens/hosts/service/main.dart';
import 'package:flyssh/utils/device.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart';

class HostsScreen extends StatefulWidget {
  const HostsScreen({super.key});

  @override
  State<HostsScreen> createState() => _HostsScreenState();
}

class _HostsScreenState extends State<HostsScreen> {
  final PagingController<int, PartialHost> _pagingController = PagingController(
    firstPageKey: 1,
  );
  int _currentActiveItem = 0;
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPhone(context)
          ? AppBar(
              title: const Text(
                "Hosts",
              ),
              centerTitle: false,
              bottom: Bottom(
                context,
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(
          BASE_SPACE * 2,
        ),
        child: Row(
          children: [
            if (!isPhone(context))
              NavigationRail(
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (value) {
                  setState(() {
                    _currentActiveItem = value;
                  });
                },
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
                  },
                  child: const Icon(
                    Icons.add_rounded,
                  ),
                ),
              ),
            if (!isPhone(context))
              const VerticalDivider(
                thickness: 1,
                width: 1,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(
                  BASE_SPACE * 3,
                ),
                child: isPhone(context)
                    ? PagedListView<int, PartialHost>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<PartialHost>(
                          itemBuilder: (context, host, index) => HostItem(
                            host: host,
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
                        double width = constraints.maxWidth;
                        int crossAxisCount;

                        if (width < 600) {
                          crossAxisCount = 2;
                        } else if (width < 900) {
                          crossAxisCount = 3;
                        } else {
                          crossAxisCount = 4;
                        }

                        return PagedGridView(
                          pagingController: _pagingController,
                          builderDelegate: PagedChildBuilderDelegate<PartialHost>(
                            itemBuilder: (context, host, index) => HostItem(
                              host: host,
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
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 4,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                        );
                      }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isPhone(context)
          ? FloatingActionButton(
              onPressed: () {
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
              },
              child: const Icon(
                Icons.add_rounded,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: isPhone(context)
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

class HostItem extends StatelessWidget {
  final PartialHost host;
  const HostItem({
    super.key,
    required this.host,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        host.label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      subtitle: Text(
        "username: ${host.username}",
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      enabled: true,
      onTap: () {},
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(Icons.terminal),
      ),
    );
  }
}
