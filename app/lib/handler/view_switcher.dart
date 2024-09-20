import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/auth/login.dart';
import 'package:flyssh/screens/home/main.dart';
import 'package:flyssh/state/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ViewSwitcher extends StatefulWidget {
  const ViewSwitcher({super.key});

  @override
  State<ViewSwitcher> createState() => _ViewSwitcherState();
}

class _ViewSwitcherState extends State<ViewSwitcher> {
  UserController u = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    hydrateController();
  }

  void hydrateController() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final masterKey = prefs.getString("master_key");
    if (token != null && token.isNotEmpty) {
      final req = await http.get(Uri.parse("$BACKEND_URL/auth/@me"), headers: {"Authorization": "Token $token"});
      final body = jsonDecode(req.body);
      if (req.statusCode != 200) return;
      u.fromJSON({...body, "token": token});
      u.setMasterKey(masterKey ?? "");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (u.token.isEmpty) {
      return const LoginScreen();
    }
    return const HomeScreen();
  }
}
