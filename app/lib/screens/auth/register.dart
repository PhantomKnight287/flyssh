import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/auth/login.dart';
import 'package:flyssh/screens/auth/master_key.dart';
import 'package:flyssh/state/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserController u = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool passwordVisible = false;
  bool loading = false;

  void register() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar("Error", "Please enter all values");
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    final req = await http.post(Uri.parse("$BACKEND_URL/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": _usernameController.text,
          "password": _passwordController.text,
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
        }));
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
    u.setMasterKey(body['master_key']);
    prefs.setString("token", body['token']);
    prefs.setString("master_key", body['master_key']);
    u.fromJSON({
      ...body,
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
    });
    Get.snackbar("Welcome", "Welcome ${body['first_name']}");
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) {
        return MasterKeyScreen(masterKey: body['master_key']);
      },
    ));
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
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "sign up to continue",
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
                      InputField(hintText: "Username", keyboardType: TextInputType.name, controller: _usernameController),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(hintText: "First Name", keyboardType: TextInputType.name, controller: _firstNameController),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(hintText: "Last Name", keyboardType: TextInputType.name, controller: _lastNameController),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: !passwordVisible,
                        maxLines: 1,
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
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: register,
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
                          "Sign Up",
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
                          return const LoginScreen();
                        },
                        fullscreenDialog: true,
                      ));
                    },
                    child: const Text(
                      "Already have an account? Log in",
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
