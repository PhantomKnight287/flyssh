import 'package:flutter/material.dart';
import 'package:flyssh/models/theme.dart';
import 'package:xterm/xterm.dart';

const dracula = CustomTerminalTheme(
  cursor: Color(0xFFbbbbbb),
  selection: Color(0xFFbbbbbb),
  foreground: Color(0xFFF8F8F2),
  background: Color(0xFF1E1F29),
  black: Color(0xFF000000),
  white: Color(0xFFbbbbbb),
  red: Color(0xFFFF5555),
  green: Color(0xFF50FA7B),
  yellow: Color(0xFFF1FA8C),
  blue: Color(0xFFBD93F9),
  magenta: Color(0xFFFF79C6),
  cyan: Color(0xFF8BE9FD),
  brightBlack: Color(0xFF555555),
  brightRed: Color(0xFFFF5555),
  brightGreen: Color(0xFF50FA7B),
  brightYellow: Color(0xFFF1FA8C),
  brightBlue: Color(0xFFBD93F9),
  brightMagenta: Color(0xFFFF79C6),
  brightCyan: Color(0xFF8BE9FD),
  brightWhite: Color(0xFFFFFFFF),
  searchHitBackground: Color(0xFFF1FA8C),
  searchHitBackgroundCurrent: Color(0xFFFF5555),
  searchHitForeground: Color(0xFF000000),
  name: "Dracula",
);

const tomorrowNightTheme = CustomTerminalTheme(
  cursor: Color(0xFFaeafad),
  selection: Color(0xFF373b41),
  foreground: Color(0xFFc5c8c6),
  background: Color(0xFF1d1f21),
  black: Color(0xFF000000),
  brightBlack: Color(0xFF666666),
  red: Color(0xFFcc6666),
  brightRed: Color(0xFFFF3334),
  green: Color(0xFFb5bd68),
  brightGreen: Color(0xFF9ec400),
  yellow: Color(0xFFde935f),
  brightYellow: Color(0xFFf0c674),
  blue: Color(0xFF81a2be),
  brightBlue: Color(0xFF81a2be),
  magenta: Color(0xFFb294bb),
  brightMagenta: Color(0xFFb777e0),
  cyan: Color(0xFF8abeb7),
  brightCyan: Color(0xFF54ced6),
  white: Color(0xFF373b41),
  brightWhite: Color(0xFF282a2e),
  searchHitBackground: Color(0xFFf0c674), // Assuming search hit background as bright yellow
  searchHitBackgroundCurrent: Color(0xFFcc6666), // Assuming search hit background current as red
  searchHitForeground: Color(0xFF000000), // Assuming search hit foreground as black
  name: "Tomorrow Night",
);

const tomorrowNightBlueTheme = CustomTerminalTheme(
  cursor: Color(0xFFaeafad),
  selection: Color(0xFF003f8e),
  foreground: Color(0xFFFFFFFF),
  background: Color(0xFF002451),
  black: Color(0xFF000000),
  red: Color(0xFFFF9DA4),
  green: Color(0xFFD1F1A9),
  yellow: Color(0xFFFFC58F),
  blue: Color(0xFFbbdaff),
  magenta: Color(0xFFebbbff),
  cyan: Color(0xFF99ffff),
  white: Color(0xFF666666),
  brightBlack: Color(0xFF666666),
  brightRed: Color(0xFFFF3334),
  brightGreen: Color(0xFF9ec400),
  brightYellow: Color(0xFFFFEEAD),
  brightBlue: Color(0xFFbbdaff),
  brightMagenta: Color(0xFFb777e0),
  brightCyan: Color(0xFF54ced6),
  brightWhite: Color(0xFF00346e),
  searchHitBackground: Color(0xFFFFEEAD), // assuming a value for searchHitBackground
  searchHitBackgroundCurrent: Color(0xFFFF9DA4), // assuming a value for searchHitBackgroundCurrent
  searchHitForeground: Color(0xFFFFFFFF), // assuming a value for searchHitForeground
  name: 'TomorrowNightBlue',
);

const tomorrowNightBrightTheme = CustomTerminalTheme(
  cursor: Color(0xFFaeafad),
  selection: Color(0xFF424242),
  foreground: Color(0xFFeaeaea),
  background: Color(0xFF000000),
  black: Color(0xFF000000),
  red: Color(0xFFd54e53),
  green: Color(0xFFb9ca4a),
  yellow: Color(0xFFe78c45),
  blue: Color(0xFF7aa6da),
  magenta: Color(0xFFc397d8),
  cyan: Color(0xFF70c0b1),
  white: Color(0xFF666666),
  brightBlack: Color(0xFF666666),
  brightRed: Color(0xFFFF3334),
  brightGreen: Color(0xFF9ec400),
  brightYellow: Color(0xFFe7c547),
  brightBlue: Color(0xFF7aa6da),
  brightMagenta: Color(0xFFb777e0),
  brightCyan: Color(0xFF54ced6),
  brightWhite: Color(0xFF2a2a2a),
  searchHitBackground: Color(0xFFe7c547), // assuming a value
  searchHitBackgroundCurrent: Color(0xFFd54e53), // assuming a value
  searchHitForeground: Color(0xFFeaeaea), // assuming a value
  name: 'TomorrowNightBright',
);

final themes = [
  CustomTerminalTheme.from(TerminalThemes.defaultTheme, name: "Default"),
  dracula,
  tomorrowNightTheme,
  tomorrowNightBrightTheme,
  tomorrowNightBlueTheme,
];
