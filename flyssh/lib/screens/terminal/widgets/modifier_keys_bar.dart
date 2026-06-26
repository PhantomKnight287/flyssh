import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:xterm/xterm.dart';

class ModifierKeysBar extends StatelessWidget {
  final Terminal terminal;
  final bool ctrlActive;
  final bool altActive;
  final VoidCallback onCtrlToggle;
  final VoidCallback onAltToggle;

  const ModifierKeysBar({
    super.key,
    required this.terminal,
    required this.ctrlActive,
    required this.altActive,
    required this.onCtrlToggle,
    required this.onAltToggle,
  });

  void _sendKey(TerminalKey key) {
    terminal.keyInput(key, ctrl: ctrlActive, alt: altActive);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: BASE_SPACE,
          vertical: BASE_SPACE,
        ),
        child: Row(
          children: [
            _ModifierKey(
              label: "ESC",
              onTap: () => _sendKey(TerminalKey.escape),
            ),
            _ModifierKey(
              label: "TAB",
              onTap: () => _sendKey(TerminalKey.tab),
            ),
            _ModifierKey(
              label: "CTRL",
              onTap: onCtrlToggle,
              isActive: ctrlActive,
            ),
            _ModifierKey(
              label: "ALT",
              onTap: onAltToggle,
              isActive: altActive,
            ),
            _BarDivider(),
            _ModifierKey(
              icon: Icons.arrow_upward,
              onTap: () => _sendKey(TerminalKey.arrowUp),
            ),
            _ModifierKey(
              icon: Icons.arrow_downward,
              onTap: () => _sendKey(TerminalKey.arrowDown),
            ),
            _ModifierKey(
              icon: Icons.arrow_back,
              onTap: () => _sendKey(TerminalKey.arrowLeft),
            ),
            _ModifierKey(
              icon: Icons.arrow_forward,
              onTap: () => _sendKey(TerminalKey.arrowRight),
            ),
            _BarDivider(),
            _ModifierKey(
              label: "HOME",
              onTap: () => _sendKey(TerminalKey.home),
            ),
            _ModifierKey(
              label: "END",
              onTap: () => _sendKey(TerminalKey.end),
            ),
            _ModifierKey(
              label: "PGUP",
              onTap: () => _sendKey(TerminalKey.pageUp),
            ),
            _ModifierKey(
              label: "PGDN",
              onTap: () => _sendKey(TerminalKey.pageDown),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModifierKey extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isActive;

  const _ModifierKey({
    this.label,
    this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceContainer;
    final fgColor = isActive
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Container(
            constraints: BoxConstraints(minWidth: 40, minHeight: 36),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: BASE_SPACE),
            child: icon != null
                ? Icon(icon, size: 18, color: fgColor)
                : Text(
                    label ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: fgColor,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _BarDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        height: 24,
        child: VerticalDivider(width: 1),
      ),
    );
  }
}
