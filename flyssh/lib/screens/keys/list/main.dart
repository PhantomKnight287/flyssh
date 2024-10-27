import 'package:flutter/material.dart';
import 'package:flyssh/components/bottom.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/hosts/service/main.dart';
import 'package:flyssh/screens/keys/create/presentation/main.dart';
import 'package:flyssh/screens/keys/service/main.dart';
import 'package:flyssh/screens/ssh/presentation/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flyssh/utils/string.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/openapi.dart';

class KeysList extends StatefulWidget {
  KeysList({
    super.key,
    required this.pagingController,
  });
  PagingController<int, PartialKey> pagingController;

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

class KeyItem extends StatelessWidget {
  final PartialKey sshKey;
  const KeyItem({
    super.key,
    required this.sshKey,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        sshKey.label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      subtitle: Text(
        "Used by ${sshKey.count.hosts} ${pluralize(sshKey.count.hosts, "host")}",
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      enabled: true,
      onTap: () {
        Navigator.of(context).push(
          CustomCupertinoRoute(
            builder: (context) {
              return SshScreen(id: sshKey.id);
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
            Icons.key,
          ),
        ),
      ),
    );
  }
}
