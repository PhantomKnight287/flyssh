import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/riverpod/user_provider.dart';
import 'package:flyssh/screens/auth/login/presentation/main.dart';
import 'package:flyssh/services/auth/main.dart';
import 'package:flyssh/utils/error.dart';
import 'package:gap/gap.dart';
import 'package:openapi/openapi.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _loading = false;
  final TextEditingController _usernameController = TextEditingController(), _passwordController = TextEditingController(), _nameController = TextEditingController();

  Future<void> _signUp(WidgetRef ref) async {
    if (!_formKey.currentState!.validate() || _loading) return;

    setState(() {
      _loading = true;
    });
    try {
      final data = await AuthenticationService.signUp(
        SignupDTO(
          (b) {
            b
              ..password = _passwordController.text
              ..username = _usernameController.text
              ..name = _nameController.text
              ..build();
          },
        ),
      );
      TextInput.finishAutofillContext();
      await const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ).write(
        key: AUTH_TOKEN_KEY,
        value: data!.token,
      );
      await const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ).write(
        key: MASTER_KEY_KEY,
        value: data.masterkey,
      );
      ref.read(userNotifierProvider.notifier).login(
            data.user.username,
            data.user.name,
            data.masterkey,
          );
      showSuccessToast(
        description: "Welcome ${data.user.username}",
      );
    } on DioException catch (e) {
      final message = getErrorMessage(e.response?.data);
      toastification.show(
        title: const Text(
          "An error occurred",
        ),
        description: Text(message),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(
          seconds: 3,
        ),
        showProgressBar: false,
      );
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
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "John Doe",
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        autoFillHints: const [
                          AutofillHints.name,
                        ],
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter your name";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
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
                        BASE_SPACE * 6,
                      ),
                      Consumer(builder: (context, ref, child) {
                        return ElevatedButton(
                          onPressed: () => _signUp(ref),
                          child: _loading
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign Up",
                                ),
                        );
                      })
                    ],
                  ),
                ),
              ),
              const Gap(
                BASE_SPACE * 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomCupertinoRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue.shade500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
