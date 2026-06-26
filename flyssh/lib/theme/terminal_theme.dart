import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart' show TerminalTheme;

class TerminalThemes {
  static TerminalTheme fromContext(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TerminalTheme(
      cursor: colorScheme.primary,
      selection: colorScheme.primary.withValues(alpha: 0.25),
      foreground: isDark ? const Color(0xFFD4D4D8) : const Color(0xFF27272A),
      background: isDark ? const Color(0xFF0C0C0E) : const Color(0xFFFAFAFB),
      black: isDark ? const Color(0xFF27272A) : const Color(0xFF3F3F46),
      red: const Color(0xFFEF4444),
      green: const Color(0xFF22C55E),
      yellow: const Color(0xFFEAB308),
      blue: const Color(0xFF3B82F6),
      magenta: const Color(0xFFA855F7),
      cyan: const Color(0xFF06B6D4),
      white: isDark ? const Color(0xFFE4E4E7) : const Color(0xFFD4D4D8),
      brightBlack: const Color(0xFF52525B),
      brightRed: const Color(0xFFF87171),
      brightGreen: const Color(0xFF4ADE80),
      brightYellow: const Color(0xFFFACC15),
      brightBlue: const Color(0xFF60A5FA),
      brightMagenta: const Color(0xFFC084FC),
      brightCyan: const Color(0xFF22D3EE),
      brightWhite: const Color(0xFFFAFAFA),
      searchHitBackground: colorScheme.primary.withValues(alpha: 0.25),
      searchHitBackgroundCurrent: colorScheme.primary.withValues(alpha: 0.45),
      searchHitForeground: colorScheme.onSurface,
    );
  }
}
