import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

class ShellView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return PlatformHelper.isDesktop
        ? _DesktopShell(navigationShell: navigationShell)
        : _MobileShell(navigationShell: navigationShell);
  }
}

class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

const _navItems = [
  _NavItem(icon: Icons.dns_outlined, selectedIcon: Icons.dns, label: "Hosts"),
  _NavItem(
      icon: Icons.vpn_key_outlined,
      selectedIcon: Icons.vpn_key,
      label: "Keys"),
  _NavItem(
      icon: Icons.terminal_outlined,
      selectedIcon: Icons.terminal,
      label: "Active Sessions"),
  _NavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: "Settings"),
];

class _DesktopShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _DesktopShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    // Give the sidebar a faintly elevated surface so it reads as a distinct
    // panel against the content area, with a crisp divider on its trailing edge.
    final base = theme.sidebarStyle;
    final sidebarStyle = FSidebarStyle(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          colors.foreground.withValues(alpha: 0.025),
          colors.background,
        ),
        border: Border(
          right: BorderSide(color: colors.border, width: theme.style.borderWidth),
        ),
      ),
      groupStyle: base.groupStyle,
      constraints: const BoxConstraints.tightFor(width: 248),
      headerPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: BASE_SPACE * 2.5),
      footerPadding: EdgeInsets.zero,
    );

    return FScaffold(
      childPad: false,
      sidebar: FSidebar(
        style: sidebarStyle,
        header: const _SidebarBrand(),
        footer: const _SidebarFooter(),
        children: [
          for (int i = 0; i < _navItems.length; i++)
            Builder(builder: (context) {
              final selected = navigationShell.currentIndex == i;
              final item = _navItems[i];
              return Padding(
                padding: EdgeInsets.only(bottom: BASE_SPACE / 2),
                child: FSidebarItem(
                  icon: Icon(
                    selected ? item.selectedIcon : item.icon,
                    color: selected ? colors.primary : null,
                  ),
                  label: Text(
                    item.label,
                    style: TextStyle(
                      color: selected ? colors.primary : null,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  selected: selected,
                  onPress: () {
                    navigationShell.goBranch(
                      i,
                      initialLocation: i == navigationShell.currentIndex,
                    );
                  },
                ),
              );
            }),
        ],
      ),
      child: navigationShell,
    );
  }
}

class _SidebarBrand extends StatelessWidget {
  const _SidebarBrand();

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return DragToMoveArea(
      child: Padding(
        // Leave room for the macOS traffic-light controls overlaid on top.
        padding: EdgeInsets.fromLTRB(
          BASE_SPACE * 2.5,
          PlatformHelper.isMacOS ? BASE_SPACE * 9 : BASE_SPACE * 4,
          BASE_SPACE * 2.5,
          BASE_SPACE * 4,
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.terminal_rounded,
                size: 18,
                color: colors.primaryForeground,
              ),
            ),
            SizedBox(width: BASE_SPACE * 2.5),
            Text(
              "FlySSH",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarFooter extends StatelessWidget {
  const _SidebarFooter();

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        BASE_SPACE * 4,
        BASE_SPACE * 2,
        BASE_SPACE * 4,
        BASE_SPACE * 4,
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: BASE_SPACE * 2),
          Text(
            "v0.1.0",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.mutedForeground,
                ),
          ),
        ],
      ),
    );
  }
}

class _MobileShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _MobileShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      footer: FBottomNavigationBar(
        index: navigationShell.currentIndex,
        onChange: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        children: const [
          FBottomNavigationBarItem(
            icon: Icon(Icons.dns_outlined),
            label: Text("Hosts"),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.vpn_key_outlined),
            label: Text("Keys"),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.terminal_outlined),
            label: Text("Sessions"),
          ),
          FBottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: Text("Settings"),
          ),
        ],
      ),
      child: navigationShell,
    );
  }
}
