import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/auth/recover/controller.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:flyssh/widgets/adaptive.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class RecoverView extends StatefulWidget {
  const RecoverView({super.key});

  @override
  State<RecoverView> createState() => _RecoverViewState();
}

class _RecoverViewState extends State<RecoverView> {
  final RecoverController controller = getIt<RecoverController>();
  bool _dialogShown = false;

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
    if (controller.recoveryComplete && controller.decryptedMasterKey != null && !_dialogShown) {
      _showRecoveryResult();
    }
  }

  void _showRecoveryResult() {
    _dialogShown = true;
    showFDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx, style, animation) => FDialog(
        style: style,
        animation: animation,
        title: const Text("Recovery Successful"),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your master key has been recovered. Copy it and use it to log in.",
            ),
            SizedBox(height: BASE_SPACE * 4),
            FCard(
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      controller.decryptedMasterKey!,
                      style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                          ),
                    ),
                  ),
                  FButton.icon(
                    onPress: () {
                      Clipboard.setData(
                        ClipboardData(text: controller.decryptedMasterKey!),
                      );
                      toastification.show(
                        title: Text("Copied to clipboard"),
                        type: ToastificationType.success,
                        autoCloseDuration: const Duration(seconds: 2),
                      );
                    },
                    child: Icon(Icons.copy, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          FButton(
            onPress: () {
              Navigator.of(ctx).pop();
              context.go('/auth/login');
            },
            child: Text("Go to Login"),
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
                    child: Column(
                      crossAxisAlignment: PlatformHelper.isDesktop
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.stretch,
                      spacing: BASE_SPACE * 2,
                      children: [
                        Text(
                          "Recover Account",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: PlatformHelper.isDesktop
                              ? TextAlign.center
                              : TextAlign.start,
                        ),
                        Text(
                          "Enter your recovery key to retrieve your master key.",
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
                          keyboardType: TextInputType.text,
                          validator: Zod()
                              .min(3, "Username is required")
                              .build,
                        ),
                        InputField(
                          hintText: "Enter your password",
                          controller: controller.passwordController,
                          obscureText: true,
                          validator: Zod()
                              .min(8, "Password must be at least 8 characters")
                              .build,
                        ),
                        InputField(
                          hintText: "Enter your recovery key",
                          controller: controller.recoveryKeyController,
                          validator: Zod()
                              .min(1, "Recovery key is required")
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
                                      controller.recover(context);
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
                                : Text("Recover"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Remember your credentials?"),
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
            );
          },
        ))),
        ],
      ),
    );
  }
}
