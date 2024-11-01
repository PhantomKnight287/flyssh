import 'package:flutter/material.dart';
import 'package:flyssh/models/theme.dart';
import 'package:xterm/xterm.dart';

final dracula = CustomTerminalTheme(
  cursor: const Color(0xFFbbbbbb),
  selection: const Color(0xFFbbbbbb),
  foreground: const Color(0xFFF8F8F2),
  background: const Color(0xFF1E1F29),
  black: const Color(0xFF000000),
  white: const Color(0xFFbbbbbb),
  red: const Color(0xFFFF5555),
  green: const Color(0xFF50FA7B),
  yellow: const Color(0xFFF1FA8C),
  blue: const Color(0xFFBD93F9),
  magenta: const Color(0xFFFF79C6),
  cyan: const Color(0xFF8BE9FD),
  brightBlack: const Color(0xFF555555),
  brightRed: const Color(0xFFFF5555),
  brightGreen: const Color(0xFF50FA7B),
  brightYellow: const Color(0xFFF1FA8C),
  brightBlue: const Color(0xFFBD93F9),
  brightMagenta: const Color(0xFFFF79C6),
  brightCyan: const Color(0xFF8BE9FD),
  brightWhite: const Color(0xFFFFFFFF),
  searchHitBackground: const Color(0xFFF1FA8C),
  searchHitBackgroundCurrent: const Color(0xFFFF5555),
  searchHitForeground: const Color(0xFF000000),
  name: "Dracula",
);

final tomorrowNightTheme = CustomTerminalTheme(
  cursor: const Color(0xFFaeafad),
  selection: const Color(0xFF373b41),
  foreground: const Color(0xFFc5c8c6),
  background: const Color(0xFF1d1f21),
  black: const Color(0xFF000000),
  brightBlack: const Color(0xFF666666),
  red: const Color(0xFFcc6666),
  brightRed: const Color(0xFFFF3334),
  green: const Color(0xFFb5bd68),
  brightGreen: const Color(0xFF9ec400),
  yellow: const Color(0xFFde935f),
  brightYellow: const Color(0xFFf0c674),
  blue: const Color(0xFF81a2be),
  brightBlue: const Color(0xFF81a2be),
  magenta: const Color(0xFFb294bb),
  brightMagenta: const Color(0xFFb777e0),
  cyan: const Color(0xFF8abeb7),
  brightCyan: const Color(0xFF54ced6),
  white: const Color(0xFF373b41),
  brightWhite: const Color(0xFF282a2e),
  searchHitBackground: const Color(0xFFf0c674), // Assuming search hit background as bright yellow
  searchHitBackgroundCurrent: const Color(0xFFcc6666), // Assuming search hit background current as red
  searchHitForeground: const Color(0xFF000000), // Assuming search hit foreground as black
  name: "Tomorrow Night",
);

final tomorrowNightBlueTheme = CustomTerminalTheme(
  cursor: const Color(0xFFaeafad),
  selection: const Color(0xFF003f8e),
  foreground: const Color(0xFFFFFFFF),
  background: const Color(0xFF002451),
  black: const Color(0xFF000000),
  red: const Color(0xFFFF9DA4),
  green: const Color(0xFFD1F1A9),
  yellow: const Color(0xFFFFC58F),
  blue: const Color(0xFFbbdaff),
  magenta: const Color(0xFFebbbff),
  cyan: const Color(0xFF99ffff),
  white: const Color(0xFF666666),
  brightBlack: const Color(0xFF666666),
  brightRed: const Color(0xFFFF3334),
  brightGreen: const Color(0xFF9ec400),
  brightYellow: const Color(0xFFFFEEAD),
  brightBlue: const Color(0xFFbbdaff),
  brightMagenta: const Color(0xFFb777e0),
  brightCyan: const Color(0xFF54ced6),
  brightWhite: const Color(0xFF00346e),
  searchHitBackground: const Color(0xFFFFEEAD), // assuming a value for searchHitBackground
  searchHitBackgroundCurrent: const Color(0xFFFF9DA4), // assuming a value for searchHitBackgroundCurrent
  searchHitForeground: const Color(0xFFFFFFFF), // assuming a value for searchHitForeground
  name: 'Tomorrow Night Blue',
);

final tomorrowNightBrightTheme = CustomTerminalTheme(
  cursor: const Color(0xFFaeafad),
  selection: const Color(0xFF424242),
  foreground: const Color(0xFFeaeaea),
  background: const Color(0xFF000000),
  black: const Color(0xFF000000),
  red: const Color(0xFFd54e53),
  green: const Color(0xFFb9ca4a),
  yellow: const Color(0xFFe78c45),
  blue: const Color(0xFF7aa6da),
  magenta: const Color(0xFFc397d8),
  cyan: const Color(0xFF70c0b1),
  white: const Color(0xFF666666),
  brightBlack: const Color(0xFF666666),
  brightRed: const Color(0xFFFF3334),
  brightGreen: const Color(0xFF9ec400),
  brightYellow: const Color(0xFFe7c547),
  brightBlue: const Color(0xFF7aa6da),
  brightMagenta: const Color(0xFFb777e0),
  brightCyan: const Color(0xFF54ced6),
  brightWhite: const Color(0xFF2a2a2a),
  searchHitBackground: const Color(0xFFe7c547), // assuming a value
  searchHitBackgroundCurrent: const Color(0xFFd54e53), // assuming a value
  searchHitForeground: const Color(0xFFeaeaea), // assuming a value
  name: 'Tomorrow Night Bright',
);

final themes = [
  CustomTerminalTheme.from(
    TerminalThemes.defaultTheme,
    name: "Default",
  ),
  dracula,
  tomorrowNightTheme,
  tomorrowNightBrightTheme,
  tomorrowNightBlueTheme,
];
