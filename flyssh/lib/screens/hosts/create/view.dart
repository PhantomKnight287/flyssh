import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/hosts/create/controller.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class HostCreateView extends StatefulWidget {
  const HostCreateView({super.key});

  @override
  State<HostCreateView> createState() => _HostCreateViewState();
}

class _HostCreateViewState extends State<HostCreateView> {
  final HostCreateController controller = getIt<HostCreateController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    controller.loadKeys();
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
        title: Text("Host created successfully"),
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

  Future<void> _showCreateKeyDialog() async {
    final labelCtrl = TextEditingController();
    final valueCtrl = TextEditingController();
    final passphraseCtrl = TextEditingController();
    final dialogFormKey = GlobalKey<FormState>();

    await showFDialog(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        style: style,
        animation: animation,
        title: const Text("Add SSH Key"),
        body: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Form(
              key: dialogFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputField(
                    label: "Key Label",
                    hintText: "e.g. My Server Key",
                    controller: labelCtrl,
                    validator: Zod().min(1, "Label is required").build,
                  ),
                  SizedBox(height: BASE_SPACE * 2),
                  InputField(
                    label: "Private Key",
                    hintText: "Paste PEM contents here",
                    controller: valueCtrl,
                    maxLines: 6,
                    validator: Zod().min(1, "Private key is required").build,
                  ),
                  SizedBox(height: BASE_SPACE),
                  FButton(
                    variant: FButtonVariant.outline,
                    onPress: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.any,
                      );
                      if (result != null && result.files.isNotEmpty) {
                        final file = result.files.first;
                        if (file.path != null) {
                          try {
                            final contents =
                                await File(file.path!).readAsString();
                            valueCtrl.text = contents;
                          } catch (_) {
                            if (ctx.mounted) {
                              toastification.show(
                                title: Text("Failed to read file"),
                                type: ToastificationType.error,
                                autoCloseDuration:
                                    const Duration(seconds: 2),
                              );
                            }
                          }
                        }
                      }
                    },
                    prefix: Icon(Icons.file_open, size: 18),
                    child: Text("Pick PEM File"),
                  ),
                  SizedBox(height: BASE_SPACE * 2),
                  InputField(
                    label: "Passphrase (optional)",
                    hintText: "Key passphrase",
                    controller: passphraseCtrl,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          FButton(
            onPress: () {
              if (dialogFormKey.currentState!.validate()) {
                Navigator.pop(ctx);
                controller.createInlineKey(
                  label: labelCtrl.text,
                  value: valueCtrl.text,
                  passphrase: passphraseCtrl.text.isNotEmpty
                      ? passphraseCtrl.text
                      : null,
                );
              }
            },
            child: Text("Add Key"),
          ),
          FButton(
            variant: FButtonVariant.outline,
            onPress: () => Navigator.pop(ctx),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "New Host",
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
                label: "Label",
                hintText: "e.g. My Server",
                controller: controller.labelController,
                validator: Zod().min(1, "Label is required").build,
              ),
              InputField(
                label: "Hostname",
                hintText: "e.g. 192.168.1.1",
                controller: controller.hostnameController,
                validator: Zod().min(1, "Hostname is required").build,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: InputField(
                      label: "Username",
                      hintText: "e.g. root",
                      controller: controller.usernameController,
                      validator:
                          Zod().min(1, "Username is required").build,
                    ),
                  ),
                  SizedBox(width: BASE_SPACE * 2),
                  Expanded(
                    child: InputField(
                      label: "Port",
                      hintText: "22",
                      controller: controller.portController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              InputField(
                label: "Password (optional)",
                hintText: "Server password",
                controller: controller.passwordController,
                obscureText: true,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SSH Key (optional)",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: BASE_SPACE),
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          child: DropdownButtonFormField<int?>(
                            decoration: InputDecoration(
                              hintText: "Select SSH Key",
                              filled: true,
                            ),
                            initialValue: controller.selectedKeyId,
                            items: [
                              DropdownMenuItem(
                                value: null,
                                child: Text("None"),
                              ),
                              ...controller.keys.map(
                                (key) => DropdownMenuItem(
                                  value: key.id,
                                  child: Text(key.label ?? 'Unnamed Key'),
                                ),
                              ),
                            ],
                            onChanged: (value) =>
                                controller.setSelectedKeyId(value),
                          ),
                        ),
                      ),
                      SizedBox(width: BASE_SPACE * 2),
                      FButton.icon(
                        onPress: controller.isCreatingKey
                            ? null
                            : _showCreateKeyDialog,
                        child: controller.isCreatingKey
                            ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: BASE_SPACE * 2),
              FButton(
                onPress: controller.isLoading
                    ? null
                    : () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.createHost(context);
                        }
                      },
                child: controller.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text("Create Host"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
