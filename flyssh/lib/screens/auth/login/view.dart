import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/auth/login/controller.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:flyssh/widgets/adaptive.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = getIt<LoginController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final error = controller.error;
    setState(() {});
    if (error != null) {
      controller.clearError();
      toastification.show(
        title: Text(error),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Column(
        children: [
          if (PlatformHelper.isMacOS) SizedBox(height: 52),
          Expanded(child: AdaptiveHelper.wrap(
        desktop: (child) {
          return Center(child: child);
        },
        mobile: (child) {
          return SafeArea(child: child);
        },
        web: (child) {
          return child;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = math.min(constraints.maxWidth, 600);
            return Container(
              constraints: BoxConstraints(maxWidth: maxWidth.toDouble()),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(BASE_SPACE * 4),
                  child: Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    child: AutofillGroup(
                      child: Column(
                        crossAxisAlignment: PlatformHelper.isDesktop
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.stretch,
                        spacing: BASE_SPACE * 2,
                        children: [
                          Text(
                            "Welcome back",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: PlatformHelper.isDesktop
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                          Text(
                            "Sign in to your FlySSH account.",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                            textAlign: PlatformHelper.isDesktop
                                ? TextAlign.center
                                : TextAlign.start,
                          ),

                          InputField(
                            hintText: "Enter your username",
                            controller: controller.usernameController,
                            autofillHints: const [
                              AutofillHints.username,
                            ],
                            validator: Zod()
                                .min(
                                  3,
                                  "Username must be at least 3 characters long",
                                )
                                .build,
                          ),
                          InputField(
                            hintText: "Enter your password",
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordShown,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordShown
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            autofillHints: const [
                              AutofillHints.password,
                            ],
                            validator: Zod()
                                .min(
                                  8,
                                  "Password must be at least 8 characters long",
                                )
                                .build,
                          ),

                          InputField(
                            hintText: "Enter your master key",
                            controller: controller.masterkeyController,
                            validator: Zod()
                                .min(1, "Master key is required")
                                .build,
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: FButton(
                              onPress: controller.isLoading
                                  ? null
                                  : () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.login(context);
                                      }
                                    },
                              child: controller.isLoading
                                  ? SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                            ),
                                      ),
                                    )
                                  : Text("Login"),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              FButton(
                                variant: FButtonVariant.ghost,
                                size: FButtonSizeVariant.sm,
                                onPress: () {
                                  context.go("/auth/register");
                                },
                                child: Text("Register"),
                              ),
                            ],
                          ),
                          FButton(
                            variant: FButtonVariant.ghost,
                            size: FButtonSizeVariant.sm,
                            onPress: () {
                              context.go("/auth/recover");
                            },
                            child: Text("Forgot your master key?"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ))),
        ],
      ),
    );
  }
}
