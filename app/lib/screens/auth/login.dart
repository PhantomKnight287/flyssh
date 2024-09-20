import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/auth/register.dart';
import 'package:flyssh/state/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserController u = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _masterKeyController = TextEditingController();
  bool passwordVisible = false;
  bool loading = false;

  void login() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar("Error", "Please enter all values");
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    final req = await http.post(Uri.parse("$BACKEND_URL/auth/login"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode({"username": _usernameController.text, "password": _passwordController.text, "master_key": _masterKeyController.text}));
    setState(() {
      loading = false;
    });
    final body = jsonDecode(req.body);
    if (req.statusCode != 200 && req.statusCode != 201) {
      Get.snackbar(
        "Error",
        body['message'] ?? "Failed to login. Try again later.",
        colorText: Colors.red,
      );
      return;
    }
    u.setMasterKey(_masterKeyController.text);
    prefs.setString("token", body['token']);
    prefs.setString("master_key", _masterKeyController.text);
    u.fromJSON(body);
    Get.snackbar("Welcome", "Welcome back $body['first_name']");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "sign in to continue",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InputField(
                        hintText: "Username",
                        keyboardType: TextInputType.name,
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: !passwordVisible,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        hintText: "Master Key",
                        keyboardType: TextInputType.text,
                        controller: _masterKeyController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your master key';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(!loading ? Colors.white : Colors.grey.shade600),
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                            (Set<MaterialState> states) {
                              return const EdgeInsets.all(15);
                            },
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      if (loading) return;
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) {
                          return const RegisterScreen();
                        },
                        fullscreenDialog: true,
                      ));
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
