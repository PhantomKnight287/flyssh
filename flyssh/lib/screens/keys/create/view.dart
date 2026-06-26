import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/keys/create/controller.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class KeyCreateView extends StatefulWidget {
  const KeyCreateView({super.key});

  @override
  State<KeyCreateView> createState() => _KeyCreateViewState();
}

class _KeyCreateViewState extends State<KeyCreateView> {
  final KeyCreateController controller = getIt<KeyCreateController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
  }

  void _onChanged() {
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
    if (controller.success) {
      toastification.show(
        title: Text("Key created successfully"),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 2),
      );
      context.pop();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    controller.dispose();
    super.dispose();
  }

  Future<void> _importKey() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    if (file.path == null) return;
    try {
      final content = await File(file.path!).readAsString();
      controller.setKeyValue(content);
    } catch (e) {
      toastification.show(
        title: Text("Failed to read file: $e"),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "New SSH Key",
      showBackButton: true,
      maxContentWidth: 600,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(BASE_SPACE * 4),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: BASE_SPACE * 3,
            children: [
              InputField(
                hintText: "Label (e.g. My Key)",
                controller: controller.labelController,
                validator: Zod().min(1, "Label is required").build,
              ),
              InputField(
                hintText: "Paste private key here",
                controller: controller.valueController,
                maxLines: 8,
                minLines: 4,
                validator: Zod().min(1, "Private key is required").build,
              ),
              FButton(
                variant: FButtonVariant.outline,
                onPress: _importKey,
                prefix: Icon(Icons.file_upload),
                child: Text("Import from file"),
              ),
              InputField(
                hintText: "Passphrase (optional)",
                controller: controller.passphraseController,
                obscureText: true,
              ),
              SizedBox(height: BASE_SPACE * 2),
              FButton(
                onPress: controller.isLoading
                    ? null
                    : () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.createKey(context);
                        }
                      },
                child: controller.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text("Create Key"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
