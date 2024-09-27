import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/switcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData.light().copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(
                Colors.black,
              ),
              foregroundColor: const WidgetStatePropertyAll(
                Colors.white,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.all(
                  BASE_SPACE * 3,
                ),
              ),
            ),
          ),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.inter(
              fontSize: 96,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
            displayMedium: GoogleFonts.inter(
              fontSize: 60,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5,
            ),
            displaySmall: GoogleFonts.inter(
              fontSize: 48,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: GoogleFonts.inter(
              fontSize: 34,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            headlineSmall: GoogleFonts.inter(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.15,
            ),
            titleMedium: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
            ),
            titleSmall: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
            labelSmall: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        home: const ScreensSwitcher(),
      ),
    );
  }
}
