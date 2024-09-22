import 'package:flutter/material.dart';
import 'package:flyssh/screens/auth/login/presentation/main.dart';

class ScreensSwitcher extends StatefulWidget {
  const ScreensSwitcher({super.key});

  @override
  State<ScreensSwitcher> createState() => _ScreensSwitcherState();
}

class _ScreensSwitcherState extends State<ScreensSwitcher> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
