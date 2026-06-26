import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Determines if a color is considered "light" (needing dark text)
bool _isLightColor(Color color) {
  final r = (color.r * 255.0).round().clamp(0, 255);
  final g = (color.g * 255.0).round().clamp(0, 255);
  final b = (color.b * 255.0).round().clamp(0, 255);
  final luminance = 0.299 * r + 0.587 * g + 0.114 * b;
  return luminance > 150;
}

/// Color theme data structure with full theme support
class ColorTheme {
  final String name;
  final Color primary;
  final Color primaryLight;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  /// Maps to the closest forui theme preset.
  final ({
    ({FPlatformThemeData light, FPlatformThemeData dark}) Function() foruiThemeFactory,
  })? _foruiMapping;

  const ColorTheme({
    required this.name,
    required this.primary,
    required this.primaryLight,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    ({({FPlatformThemeData light, FPlatformThemeData dark}) Function() foruiThemeFactory})? foruiMapping,
  }) : _foruiMapping = foruiMapping;

  /// Returns the matching forui theme set.
  ({FPlatformThemeData light, FPlatformThemeData dark}) get foruiTheme {
    if (_foruiMapping != null) {
      return _foruiMapping.foruiThemeFactory();
    }
    // Default to zinc
    return (light: FThemes.zinc.light, dark: FThemes.zinc.dark);
  }

  /// Whether this color theme needs dark text on the primary color
  bool get needsDarkTextOnPrimary => _isLightColor(primary);

  /// The color to use for text/icons on the primary color
  Color get onPrimary =>
      needsDarkTextOnPrimary ? const Color(0xFF1A1A1A) : Colors.white;

  /// The color to use for text/icons on the primaryLight color
  Color get onPrimaryLight =>
      _isLightColor(primaryLight) ? const Color(0xFF1A1A1A) : Colors.white;

  // ── Light theme surfaces ──────────────────────────────────────────

  Color get lightSurface => const Color(0xFFF7F7F8);

  Color get lightSurfaceContainer => const Color(0xFFEFEFF1);

  Color get lightBackground => const Color(0xFFFFFFFF);

  // ── Dark theme surfaces ───────────────────────────────────────────

  Color get darkSurface => const Color(0xFF1C1C1E);

  Color get darkSurfaceContainer => const Color(0xFF2C2C2E);

  Color get darkBackground => const Color(0xFF0F0F11);
}

/// Available color themes — curated set of professional, non-garish options
class ColorThemes {
  static final ColorTheme blue = ColorTheme(
    name: 'Blue',
    primary: Color(0xFF3478F6),
    primaryLight: Color(0xFF5A9CFF),
    primaryContainer: Color(0xFFE8F0FE),
    onPrimaryContainer: Color(0xFF0A2463),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.blue.light, dark: FThemes.blue.dark)),
  );

  static final ColorTheme indigo = ColorTheme(
    name: 'Indigo',
    primary: Color(0xFF5856D6),
    primaryLight: Color(0xFF7B79E8),
    primaryContainer: Color(0xFFECECFB),
    onPrimaryContainer: Color(0xFF1E1B4B),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.violet.light, dark: FThemes.violet.dark)),
  );

  static final ColorTheme purple = ColorTheme(
    name: 'Purple',
    primary: Color(0xFF8B5CF6),
    primaryLight: Color(0xFFA78BFA),
    primaryContainer: Color(0xFFF0EBFE),
    onPrimaryContainer: Color(0xFF3B1F7A),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.violet.light, dark: FThemes.violet.dark)),
  );

  static final ColorTheme pink = ColorTheme(
    name: 'Pink',
    primary: Color(0xFFEC4899),
    primaryLight: Color(0xFFF472B6),
    primaryContainer: Color(0xFFFDE8F3),
    onPrimaryContainer: Color(0xFF6D1A4A),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.rose.light, dark: FThemes.rose.dark)),
  );

  static final ColorTheme red = ColorTheme(
    name: 'Red',
    primary: Color(0xFFEF4444),
    primaryLight: Color(0xFFF87171),
    primaryContainer: Color(0xFFFEE8E8),
    onPrimaryContainer: Color(0xFF7F1D1D),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.red.light, dark: FThemes.red.dark)),
  );

  static final ColorTheme orange = ColorTheme(
    name: 'Orange',
    primary: Color(0xFFF97316),
    primaryLight: Color(0xFFFB923C),
    primaryContainer: Color(0xFFFFF1E6),
    onPrimaryContainer: Color(0xFF7C2D12),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.orange.light, dark: FThemes.orange.dark)),
  );

  static final ColorTheme green = ColorTheme(
    name: 'Green',
    primary: Color(0xFF22C55E),
    primaryLight: Color(0xFF4ADE80),
    primaryContainer: Color(0xFFE6F9ED),
    onPrimaryContainer: Color(0xFF14532D),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.green.light, dark: FThemes.green.dark)),
  );

  static final ColorTheme teal = ColorTheme(
    name: 'Teal',
    primary: Color(0xFF14B8A6),
    primaryLight: Color(0xFF2DD4BF),
    primaryContainer: Color(0xFFE6FAF7),
    onPrimaryContainer: Color(0xFF134E4A),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.green.light, dark: FThemes.green.dark)),
  );

  static final ColorTheme cyan = ColorTheme(
    name: 'Cyan',
    primary: Color(0xFF06B6D4),
    primaryLight: Color(0xFF22D3EE),
    primaryContainer: Color(0xFFE5F8FB),
    onPrimaryContainer: Color(0xFF164E63),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.blue.light, dark: FThemes.blue.dark)),
  );

  static final ColorTheme slate = ColorTheme(
    name: 'Slate',
    primary: Color(0xFF64748B),
    primaryLight: Color(0xFF94A3B8),
    primaryContainer: Color(0xFFEFF1F3),
    onPrimaryContainer: Color(0xFF1E293B),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.slate.light, dark: FThemes.slate.dark)),
  );

  static final ColorTheme rose = ColorTheme(
    name: 'Rose',
    primary: Color(0xFFF43F5E),
    primaryLight: Color(0xFFFB7185),
    primaryContainer: Color(0xFFFEE8EB),
    onPrimaryContainer: Color(0xFF881337),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.rose.light, dark: FThemes.rose.dark)),
  );

  static final ColorTheme amber = ColorTheme(
    name: 'Amber',
    primary: Color(0xFFD97706),
    primaryLight: Color(0xFFFBBF24),
    primaryContainer: Color(0xFFFEF3C7),
    onPrimaryContainer: Color(0xFF78350F),
    foruiMapping: (foruiThemeFactory: () => (light: FThemes.yellow.light, dark: FThemes.yellow.dark)),
  );

  static final List<ColorTheme> all = [
    blue,
    indigo,
    purple,
    pink,
    rose,
    red,
    orange,
    amber,
    green,
    teal,
    cyan,
    slate,
  ];

  static ColorTheme? getByName(String name) {
    try {
      return all.firstWhere((theme) => theme.name == name);
    } catch (e) {
      return null;
    }
  }
}
