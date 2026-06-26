import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/keys/edit/controller.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class KeyEditView extends StatefulWidget {
  final String keyId;

  const KeyEditView({super.key, required this.keyId});

  @override
  State<KeyEditView> createState() => _KeyEditViewState();
}

class _KeyEditViewState extends State<KeyEditView> {
  final KeyEditController controller = getIt<KeyEditController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    controller.loadKey(widget.keyId);
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
        title: Text("Key updated successfully"),
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

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "Edit SSH Key",
      showBackButton: true,
      maxContentWidth: 600,
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(BASE_SPACE * 4),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: BASE_SPACE * 3,
                  children: [
                    InputField(
                      hintText: "Label",
                      controller: controller.labelController,
                      validator: Zod().min(1, "Label is required").build,
                    ),
                    InputField(
                      hintText: "New private key (leave empty to keep current)",
                      controller: controller.valueController,
                      maxLines: 8,
                      minLines: 4,
                    ),
                    InputField(
                      hintText: "New passphrase (leave empty to keep current)",
                      controller: controller.passphraseController,
                      obscureText: true,
                    ),
                    SizedBox(height: BASE_SPACE * 2),
                    FButton(
                      onPress: controller.isLoading
                          ? null
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateKey(context, widget.keyId);
                              }
                            },
                      child: controller.isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text("Update Key"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
