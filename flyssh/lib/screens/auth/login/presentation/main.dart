import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:gap/gap.dart';
import 'package:openapi/openapi.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isMasterKeyVisible = false;
  final _loginApi = openapi.getAuthenticationApi();
  bool _loading = false;
  final TextEditingController _usernameController = TextEditingController(), _passwordController = TextEditingController(), _masterKeyController = TextEditingController();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate() || _loading) return;
    try {
      setState(() {
        _loading = true;
      });
      await _loginApi.authControllerLogin(
        loginDTO: LoginDTO(
          (b) {
            b
              ..masterkey = _masterKeyController.text
              ..password = _passwordController.text
              ..username = _usernameController.text
              ..build();
          },
        ),
      );
    } on DioException catch (e) {
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            BASE_SPACE * 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Lets sign you in",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(
                BASE_SPACE,
              ),
              Text(
                "Welcome back! We're glad to see you again. Please enter your details to sign in.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const Gap(
                BASE_SPACE * 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(
                      BASE_SPACE * 2,
                    ),
                    InputField(
                      hintText: "phantomknight287",
                      keyboardType: TextInputType.name,
                      controller: _usernameController,
                      autoFillHints: const [
                        AutofillHints.username,
                      ],
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) return "Please enter your username";
                        return null;
                      },
                    ),
                    const Gap(
                      BASE_SPACE * 4,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(
                      BASE_SPACE * 2,
                    ),
                    InputField(
                      hintText: "*********",
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      keyboardType: TextInputType.name,
                      autoFillHints: const [
                        AutofillHints.password,
                      ],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) return "Please enter your password";
                        return null;
                      },
                    ),
                    const Gap(
                      BASE_SPACE * 4,
                    ),
                    Text(
                      "Master Key",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(
                      BASE_SPACE * 2,
                    ),
                    InputField(
                      hintText: "*********",
                      controller: _masterKeyController,
                      obscureText: !_isMasterKeyVisible,
                      keyboardType: TextInputType.name,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isMasterKeyVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isMasterKeyVisible = !_isMasterKeyVisible;
                          });
                        },
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) return "Please enter your master key";
                        return null;
                      },
                    ),
                    const Gap(
                      BASE_SPACE * 6,
                    ),
                    ElevatedButton(
                      onPressed: _login,
                      child: _loading
                          ? CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Sign In",
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
