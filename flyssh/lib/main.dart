import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/interceptors/main.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/router/main.dart';
import 'package:flyssh/services/settings.dart';
import 'package:flyssh/theme/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  dio.interceptors.add(TokenInterceptor());
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: Platform.isMacOS ? TitleBarStyle.hidden : null,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final SettingsService _settingsService = getIt<SettingsService>();
  late final _router = FlysshRouter().router;
  late final _fontFamily = GoogleFonts.inter().fontFamily;

  @override
  void initState() {
    super.initState();
    _settingsService.addListener(_onSettingsChanged);
  }

  void _onSettingsChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _settingsService.removeListener(_onSettingsChanged);
    super.dispose();
  }

  FThemeData _foruiTheme(Brightness brightness) {
    final isTouch = const <TargetPlatform>{
      TargetPlatform.android,
      TargetPlatform.iOS,
      TargetPlatform.fuchsia,
    }.contains(defaultTargetPlatform);

    final themeSet = _settingsService.colorTheme.foruiTheme;
    final brightnessTheme =
        brightness == Brightness.dark ? themeSet.dark : themeSet.light;
    return isTouch ? brightnessTheme.touch : brightnessTheme.desktop;
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = _settingsService.colorTheme;
    final themeMode = _settingsService.themeMode;

    final brightness = themeMode == ThemeMode.dark
        ? Brightness.dark
        : themeMode == ThemeMode.light
            ? Brightness.light
            : MediaQuery.platformBrightnessOf(context);

    final fTheme = _foruiTheme(brightness);

    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'FlySsh',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        supportedLocales: FLocalizations.supportedLocales,
        localizationsDelegates: FLocalizations.localizationsDelegates,
        theme: AppTheme.lightTheme(
          fontFamily: _fontFamily,
          colorTheme: colorTheme,
        ),
        darkTheme: AppTheme.darkTheme(
          fontFamily: _fontFamily,
          colorTheme: colorTheme,
        ),
        themeMode: themeMode,
        builder: (context, child) => FTheme(
          data: fTheme,
          child: child!,
        ),
      ),
    );
  }
}
