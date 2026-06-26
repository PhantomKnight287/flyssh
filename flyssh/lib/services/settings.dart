import 'package:flutter/material.dart';
import 'package:flyssh/theme/color_theme.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SettingsService extends ChangeNotifier {
  static const _themeModeKey = 'theme_mode';
  static const _colorThemeKey = 'color_theme';

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ColorTheme _colorTheme = ColorThemes.blue;
  ColorTheme get colorTheme => _colorTheme;

  SettingsService() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_themeModeKey) ?? 0;
    _themeMode = ThemeMode.values[modeIndex];
    final themeName = prefs.getString(_colorThemeKey) ?? 'Blue';
    _colorTheme = ColorThemes.getByName(themeName) ?? ColorThemes.blue;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  Future<void> setColorTheme(ColorTheme theme) async {
    _colorTheme = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_colorThemeKey, theme.name);
  }
}
