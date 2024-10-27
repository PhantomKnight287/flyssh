import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/riverpod/user_provider.dart';
import 'package:flyssh/screens/hosts/list/presentation/main.dart';
import 'package:flyssh/services/auth/main.dart';
import 'package:flyssh/screens/auth/sign_up/presentation/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flyssh/utils/error.dart';
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
  bool _loading = false;
  final TextEditingController _usernameController = TextEditingController(), _passwordController = TextEditingController(), _masterKeyController = TextEditingController();

  Future<void> _login(WidgetRef ref) async {
    if (!_formKey.currentState!.validate() || _loading) return;
    setState(() {
      _loading = true;
    });

    final data = await AuthenticationService.login(
      LoginDTO(
        (b) {
          b
            ..masterkey = _masterKeyController.text.trim()
            ..password = _passwordController.text.trim()
            ..username = _usernameController.text.trim()
            ..build();
        },
      ),
    );
    setState(() {
      _loading = false;
    });
    if (data.hasError) {
      showErrorToast(data.error);
      return;
    }
    final body = data.value!.data;
    TextInput.finishAutofillContext();
    await const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ).write(
      key: AUTH_TOKEN_KEY,
      value: body!.token,
    );
    await const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ).write(
      key: MASTER_KEY_KEY,
      value: _masterKeyController.text.trim(),
    );
    ref.read(userNotifierProvider.notifier).login(
          body.user.username,
          body.user.name,
          _masterKeyController.text,
        );
    showSuccessToast(
      description: "Welcome back ${body.user.name}",
    );
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        CustomCupertinoRoute(
          builder: (context) {
            return const HostsScreen();
          },
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  BASE_SPACE * 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: isPhone() ? MainAxisAlignment.start : MainAxisAlignment.center,
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
                            Consumer(
                              builder: (context, ref, child) {
                                return ElevatedButton(
                                  onPressed: () => _login(ref),
                                  child: _loading
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Sign In",
                                        ),
                                );
                              },
                            )
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
                          "Don't have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomCupertinoRoute(
                                builder: (context) {
                                  return const SignUpScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign up",
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
          ),
        ),
      ),
    );
  }
}
