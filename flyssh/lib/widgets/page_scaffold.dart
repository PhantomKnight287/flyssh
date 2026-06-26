import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showBackButton;
  final double? maxContentWidth;

  const PageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showBackButton = false,
    this.maxContentWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (PlatformHelper.isDesktop) {
      return _DesktopPageScaffold(
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton,
        showBackButton: showBackButton,
        maxContentWidth: maxContentWidth,
      );
    }
    return _MobilePageScaffold(
      title: title,
      actions: actions,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

class _MobilePageScaffold extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget body;
  final Widget? floatingActionButton;

  const _MobilePageScaffold({
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(title),
        suffixes: [
          if (actions != null)
            ...actions!.map((action) => _wrapAction(action)),
        ],
      ),
      child: Stack(
        children: [
          body,
          if (floatingActionButton != null)
            Positioned(
              right: BASE_SPACE * 4,
              bottom: BASE_SPACE * 4,
              child: floatingActionButton!,
            ),
        ],
      ),
    );
  }

  Widget _wrapAction(Widget action) {
    if (action is IconButton) {
      return FHeaderAction(
        icon: (action.icon as Icon?) ?? const Icon(Icons.more_vert),
        onPress: action.onPressed,
      );
    }
    return action;
  }
}

class _DesktopPageScaffold extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showBackButton;
  final double? maxContentWidth;

  const _DesktopPageScaffold({
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showBackButton = false,
    this.maxContentWidth,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body;
    if (maxContentWidth != null) {
      content = Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth!),
          child: content,
        ),
      );
    }

    return FScaffold(
      header: FHeader(
        title: DragToMoveArea(
          child: Row(
            children: [
              if (showBackButton) ...[
                FButton(
                  variant: FButtonVariant.ghost,
                  size: FButtonSizeVariant.sm,
                  onPress: () => context.pop(),
                  prefix: const Icon(Icons.arrow_back, size: 18),
                  child: const Text("Back"),
                ),
                SizedBox(width: BASE_SPACE * 2),
              ],
              Text(title),
              const Spacer(),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
      child: Stack(
        children: [
          content,
          if (floatingActionButton != null)
            Positioned(
              right: BASE_SPACE * 4,
              bottom: BASE_SPACE * 4,
              child: floatingActionButton!,
            ),
        ],
      ),
    );
  }
}
