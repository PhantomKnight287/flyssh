// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyssh/theme/color_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static String? _getFontFamily(String? fontName) {
    if (fontName == null || fontName.isEmpty) {
      return GoogleFonts.inter().fontFamily;
    }
    try {
      return GoogleFonts.getFont(fontName).fontFamily;
    } catch (e) {
      return GoogleFonts.inter().fontFamily;
    }
  }

  // ── Light palette ───────────────────────────────────────────────
  static const _lightText = Color(0xFF1A1A1A);
  static const _lightTextSecondary = Color(0xFF71717A);

  // ── Dark palette ────────────────────────────────────────────────
  static const _darkText = Color(0xFFECECEE);
  static const _darkTextSecondary = Color(0xFF8E8E93);

  // ── Shared radii ────────────────────────────────────────────────
  static const _radius = 8.0;
  static const _radiusLg = 12.0;

  // ── Border width ────────────────────────────────────────────────
  static const _borderWidth = 1.0;

  static ThemeData lightTheme({
    String? fontFamily,
    ColorTheme? colorTheme,
  }) {
    colorTheme ??= ColorThemes.blue;
    final background = colorTheme.lightBackground;
    final surface = colorTheme.lightSurface;
    final surfaceContainer = colorTheme.lightSurfaceContainer;
    final border = const Color(0xFFE4E4E7);
    final borderSubtle = const Color(0xFFEEEEF0);

    final colorScheme = ColorScheme.light(
      primary: colorTheme.primary,
      onPrimary: colorTheme.onPrimary,
      primaryContainer: colorTheme.primaryContainer,
      onPrimaryContainer: colorTheme.onPrimaryContainer,
      secondary: colorTheme.primary,
      onSecondary: colorTheme.onPrimary,
      surface: background,
      onSurface: _lightText,
      surfaceContainerHighest: surface,
      surfaceContainerHigh: surfaceContainer,
      surfaceContainer: surfaceContainer,
      outline: border,
      outlineVariant: borderSubtle,
      onSurfaceVariant: _lightTextSecondary,
      error: const Color(0xFFDC2626),
      onError: Colors.white,
    );

    final font = _getFontFamily(fontFamily);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      fontFamily: font,
      scaffoldBackgroundColor: background,

      // ── AppBar ────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: _lightText,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: _lightText,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: font,
          letterSpacing: -0.2,
        ),
      ),

      // ── Card ──────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: border, width: _borderWidth),
        ),
      ),

      // ── ListTile ──────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
      ),

      // ── Divider ───────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: border,
        thickness: _borderWidth,
        space: _borderWidth,
      ),

      // ── Input ─────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: border, width: _borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: border, width: _borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: colorTheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide:
              const BorderSide(color: Color(0xFFDC2626), width: _borderWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: TextStyle(
          color: _lightTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Elevated button ───────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorTheme.primary,
          foregroundColor: colorTheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: font,
            letterSpacing: -0.1,
          ),
        ),
      ),

      // ── Text button ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorTheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: font,
            letterSpacing: -0.1,
          ),
        ),
      ),

      // ── Outlined button ───────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _lightText,
          side: BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: font,
            letterSpacing: -0.1,
          ),
        ),
      ),

      // ── Icon ──────────────────────────────────────────────────
      iconTheme: IconThemeData(color: _lightText, size: 20),

      // ── Text ──────────────────────────────────────────────────
      textTheme: _textTheme(_lightText, _lightTextSecondary),

      // ── NavigationBar ─────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: background,
        indicatorColor: colorTheme.primaryContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: colorTheme!.primary,
              letterSpacing: 0,
            );
          }
          return TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: _lightTextSecondary,
            letterSpacing: 0,
          );
        }),
      ),

      // ── NavigationRail ────────────────────────────────────────
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        selectedIconTheme: IconThemeData(color: colorTheme.primary),
        unselectedIconTheme: IconThemeData(color: _lightTextSecondary),
        selectedLabelTextStyle: TextStyle(
          color: colorTheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: _lightTextSecondary,
          fontSize: 12,
        ),
        indicatorColor: colorTheme.primaryContainer,
      ),

      // ── Dialog ────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: background,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusLg),
          side: BorderSide(color: border, width: _borderWidth),
        ),
      ),

      // ── Popup menu ────────────────────────────────────────────
      popupMenuTheme: PopupMenuThemeData(
        color: background,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: border, width: _borderWidth),
        ),
      ),

      // ── FAB ───────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorTheme.primary,
        foregroundColor: colorTheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusLg),
        ),
      ),

      // ── SegmentedButton ───────────────────────────────────────
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: border, width: _borderWidth),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme({
    String? fontFamily,
    ColorTheme? colorTheme,
  }) {
    colorTheme ??= ColorThemes.blue;
    final background = colorTheme.darkBackground;
    final surface = colorTheme.darkSurface;
    final surfaceContainer = colorTheme.darkSurfaceContainer;
    final border = const Color(0xFF2C2C2E);
    final borderSubtle = const Color(0xFF232325);

    final pr = (colorTheme.primary.r * 255.0).round().clamp(0, 255);
    final pg = (colorTheme.primary.g * 255.0).round().clamp(0, 255);
    final pb = (colorTheme.primary.b * 255.0).round().clamp(0, 255);
    final darkPrimaryContainer = Color.fromRGBO(
      (pr * 0.15).round(),
      (pg * 0.15).round(),
      (pb * 0.25).round(),
      1.0,
    );

    final colorScheme = ColorScheme.dark(
      primary: colorTheme.primaryLight,
      onPrimary: colorTheme.onPrimaryLight,
      primaryContainer: darkPrimaryContainer,
      onPrimaryContainer: colorTheme.primaryContainer,
      secondary: const Color(0xFF2C2C2E),
      onSecondary: Colors.white,
      surface: background,
      onSurface: _darkText,
      surfaceContainerHighest: surface,
      surfaceContainerHigh: surfaceContainer,
      surfaceContainer: surfaceContainer,
      outline: border,
      outlineVariant: borderSubtle,
      onSurfaceVariant: _darkTextSecondary,
      error: const Color(0xFFEF4444),
      onError: Colors.white,
    );

    final font = _getFontFamily(fontFamily);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: font,
      scaffoldBackgroundColor: background,

      // ── AppBar ────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: _darkText,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: _darkText,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: font,
          letterSpacing: -0.2,
        ),
      ),

      // ── Card ──────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: border, width: _borderWidth),
        ),
      ),

      // ── ListTile ──────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
      ),

      // ── Divider ───────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: border,
        thickness: _borderWidth,
        space: _borderWidth,
      ),

      // ── Input ─────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: border, width: _borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: border, width: _borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide:
              BorderSide(color: colorTheme.primaryLight, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide:
              const BorderSide(color: Color(0xFFEF4444), width: _borderWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: TextStyle(
          color: _darkTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Elevated button ───────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorTheme.primaryLight,
          foregroundColor: colorTheme.onPrimaryLight,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: font,
            letterSpacing: -0.1,
          ),
        ),
      ),

      // ── Text button ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorTheme.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: font,
            letterSpacing: -0.1,
          ),
        ),
      ),

      // ── Outlined button ───────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _darkText,
          side: BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: font,
            letterSpacing: -0.1,
          ),
        ),
      ),

      // ── Icon ──────────────────────────────────────────────────
      iconTheme: IconThemeData(color: _darkText, size: 20),

      // ── Text ──────────────────────────────────────────────────
      textTheme: _textTheme(_darkText, _darkTextSecondary),

      // ── NavigationBar ─────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: background,
        indicatorColor: darkPrimaryContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: colorTheme!.primaryLight,
              letterSpacing: 0,
            );
          }
          return TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: _darkTextSecondary,
            letterSpacing: 0,
          );
        }),
      ),

      // ── NavigationRail ────────────────────────────────────────
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        selectedIconTheme: IconThemeData(color: colorTheme.primaryLight),
        unselectedIconTheme: IconThemeData(color: _darkTextSecondary),
        selectedLabelTextStyle: TextStyle(
          color: colorTheme.primaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: _darkTextSecondary,
          fontSize: 12,
        ),
        indicatorColor: darkPrimaryContainer,
      ),

      // ── Dialog ────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusLg),
          side: BorderSide(color: border, width: _borderWidth),
        ),
      ),

      // ── Popup menu ────────────────────────────────────────────
      popupMenuTheme: PopupMenuThemeData(
        color: surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: border, width: _borderWidth),
        ),
      ),

      // ── FAB ───────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorTheme.primaryLight,
        foregroundColor: colorTheme.onPrimaryLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusLg),
        ),
      ),

      // ── SegmentedButton ───────────────────────────────────────
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: border, width: _borderWidth),
          ),
        ),
      ),
    );
  }

  /// Shared text theme — tight tracking, clean hierarchy
  static TextTheme _textTheme(Color text, Color textSecondary) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: text,
        letterSpacing: -0.5,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: text,
        letterSpacing: -0.4,
        height: 1.15,
      ),
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.3,
        height: 1.2,
      ),
      headlineLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.3,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.2,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.2,
        height: 1.35,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.2,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.1,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: text,
        letterSpacing: -0.05,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: text,
        letterSpacing: -0.1,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: text,
        letterSpacing: -0.05,
        height: 1.45,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        letterSpacing: 0,
        height: 1.35,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: text,
        letterSpacing: -0.05,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0.1,
      ),
    );
  }
}
