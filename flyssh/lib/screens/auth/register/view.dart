import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/auth/register/controller.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:flyssh/widgets/adaptive.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController controller = getIt<RegisterController>();

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
    if (controller.registrationComplete) {
      _showKeysDialog();
    }
  }

  void _showKeysDialog() {
    showFDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx, style, animation) => FDialog(
        style: style,
        animation: animation,
        title: const Text("Save Your Keys"),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Save these keys securely. You will need them to log in and recover your account.",
              ),
              SizedBox(height: BASE_SPACE * 4),
              Text("Master Key", style: Theme.of(ctx).textTheme.titleSmall),
              SizedBox(height: BASE_SPACE),
              _KeyDisplayWidget(
                value: controller.masterKey ?? '',
                label: "Master Key",
              ),
              SizedBox(height: BASE_SPACE * 4),
              Text("Recovery Key", style: Theme.of(ctx).textTheme.titleSmall),
              SizedBox(height: BASE_SPACE),
              _KeyDisplayWidget(
                value: controller.recoveryKey ?? '',
                label: "Recovery Key",
              ),
            ],
          ),
        ),
        actions: [
          FButton(
            onPress: () {
              Navigator.of(ctx).pop();
              context.go('/hosts');
            },
            child: Text("I've saved my keys"),
          ),
        ],
      ),
    );
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
        desktop: (child) => Center(child: child),
        mobile: (child) => child,
        web: (child) => child,
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
                            "Create Account",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: PlatformHelper.isDesktop
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                          Text(
                            "Sign up for a FlySSH account.",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                            textAlign: PlatformHelper.isDesktop
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                          InputField(
                            hintText: "Enter your name",
                            controller: controller.nameController,
                            autofillHints: const [AutofillHints.name],
                            validator: Zod()
                                .min(1, "Name is required")
                                .build,
                          ),
                          InputField(
                            hintText: "Enter your username",
                            controller: controller.usernameController,
                            keyboardType: TextInputType.text,
                            autofillHints: const [AutofillHints.username],
                            validator: Zod()
                                .min(3, "Username must be at least 3 characters")
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
                            autofillHints: const [AutofillHints.newPassword],
                            validator: Zod()
                                .min(8,
                                    "Password must be at least 8 characters long")
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
                                        controller.register(context);
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
                                          Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    )
                                  : Text("Register"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              FButton(
                                variant: FButtonVariant.ghost,
                                size: FButtonSizeVariant.sm,
                                onPress: () {
                                  context.go("/auth/login");
                                },
                                child: Text("Login"),
                              ),
                            ],
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

class _KeyDisplayWidget extends StatelessWidget {
  final String value;
  final String label;

  const _KeyDisplayWidget({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ),
          FButton.icon(
            onPress: () {
              Clipboard.setData(ClipboardData(text: value));
              toastification.show(
                title: Text("$label copied to clipboard"),
                type: ToastificationType.success,
                autoCloseDuration: const Duration(seconds: 2),
              );
            },
            child: Icon(Icons.copy, size: 18),
          ),
        ],
      ),
    );
  }
}
