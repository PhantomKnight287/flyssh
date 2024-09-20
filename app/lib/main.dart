import 'package:flutter/material.dart';
import 'package:flyssh/handler/view_switcher.dart';
import 'package:get/get.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        fontFamily: "Geist",
        brightness: Brightness.light,
      ),
      dark: ThemeData(
        useMaterial3: true,
        fontFamily: "Geist",
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          background: Colors.black,
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => GetMaterialApp(
        title: 'FlySSH',
        home: const ViewSwitcher(),
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
      ),
    );
  }
}
