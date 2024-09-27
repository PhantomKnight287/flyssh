import 'package:flutter/material.dart';
import 'package:flyssh/components/bottom.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/hosts/create/presentation/main.dart';
import 'package:flyssh/screens/hosts/service/main.dart';

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
      appBar: AppBar(
        title: const Text(
          "Hosts",
        ),
        centerTitle: false,
        bottom: Bottom(
          context,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          BASE_SPACE * 2,
        ),
        child: PagedListView<int, PartialHost>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<PartialHost>(
            itemBuilder: (context, host, index) => ListTile(
              title: Text(
                host.label,
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
              onLongPress: () {},
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
            ),
            noItemsFoundIndicatorBuilder: (context) {
              return const Center(
                child: Text(
                  "No hosts found, add one",
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
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
      ),
    );
  }
}