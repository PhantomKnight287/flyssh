import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/hosts/edit/controller.dart';
import 'package:flyssh/widgets/input.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zod_validation/zod_validation.dart';

class HostEditView extends StatefulWidget {
  final String hostId;

  const HostEditView({super.key, required this.hostId});

  @override
  State<HostEditView> createState() => _HostEditViewState();
}

class _HostEditViewState extends State<HostEditView> {
  final HostEditController controller = getIt<HostEditController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChanged);
    controller.loadHost(widget.hostId);
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
        title: Text("Host updated successfully"),
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
      title: "Edit Host",
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
                      hintText: "Hostname",
                      controller: controller.hostnameController,
                      validator: Zod().min(1, "Hostname is required").build,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: InputField(
                            hintText: "Username",
                            controller: controller.usernameController,
                            validator:
                                Zod().min(1, "Username is required").build,
                          ),
                        ),
                        SizedBox(width: BASE_SPACE * 2),
                        Expanded(
                          child: InputField(
                            hintText: "Port",
                            controller: controller.portController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    InputField(
                      hintText: "New Password (leave empty to keep current)",
                      controller: controller.passwordController,
                      obscureText: true,
                    ),
                  Material(
                      child: DropdownButtonFormField<int?>(
                        decoration: InputDecoration(
                          hintText: "Select SSH Key (optional)",
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
                    SizedBox(height: BASE_SPACE * 2),
                    FButton(
                      onPress: controller.isLoading
                          ? null
                          : () {
                              if (controller.formKey.currentState!
                                  .validate()) {
                                controller.updateHost(
                                    context, widget.hostId);
                              }
                            },
                      child: controller.isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2),
                            )
                          : Text("Update Host"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
