import 'package:xterm/xterm.dart';

class CustomTerminalTheme extends TerminalTheme {
  final String name;

  const CustomTerminalTheme({
    required super.cursor,
    required super.selection,
    required super.foreground,
    required super.background,
    required super.black,
    required super.white,
    required super.red,
    required super.green,
    required super.yellow,
    required super.blue,
    required super.magenta,
    required super.cyan,
    required super.brightBlack,
    required super.brightRed,
    required super.brightGreen,
    required super.brightYellow,
    required super.brightBlue,
    required super.brightMagenta,
    required super.brightCyan,
    required super.brightWhite,
    required super.searchHitBackground,
    required super.searchHitBackgroundCurrent,
    required super.searchHitForeground,
    required this.name,
  });
  factory CustomTerminalTheme.from(TerminalTheme other, {String name = 'default'}) {
    return CustomTerminalTheme(
      cursor: other.cursor,
      selection: other.selection,
      foreground: other.foreground,
      background: other.background,
      black: other.black,
      white: other.white,
      red: other.red,
      green: other.green,
      yellow: other.yellow,
      blue: other.blue,
      magenta: other.magenta,
      cyan: other.cyan,
      brightBlack: other.brightBlack,
      brightRed: other.brightRed,
      brightGreen: other.brightGreen,
      brightYellow: other.brightYellow,
      brightBlue: other.brightBlue,
      brightMagenta: other.brightMagenta,
      brightCyan: other.brightCyan,
      brightWhite: other.brightWhite,
      searchHitBackground: other.searchHitBackground,
      searchHitBackgroundCurrent: other.searchHitBackgroundCurrent,
      searchHitForeground: other.searchHitForeground,
      name: name,
    );
  }
}
