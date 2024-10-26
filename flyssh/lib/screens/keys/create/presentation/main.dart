import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:gap/gap.dart';

class CreateKeyScreen extends StatefulWidget {
  const CreateKeyScreen({super.key});

  @override
  State<CreateKeyScreen> createState() => _CreateKeyScreenState();
}

class _CreateKeyScreenState extends State<CreateKeyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController(), _keyController = TextEditingController(), _passphraseController = TextEditingController();
  bool _loading = false;
  bool _passwordShown = false;
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isPhone = isPhone(context);
    return Scaffold(
      appBar: _isPhone
          ? AppBar(
              title: const Text(
                "Add new key",
              ),
              centerTitle: false,
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  BASE_SPACE * 2,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!_isPhone)
                        Builder(
                          builder: (context) {
                            return Column(
                              children: [
                                const Gap(
                                  BASE_SPACE * 4,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: Navigator.of(context).pop,
                                      icon: const Icon(
                                        Icons.arrow_back_rounded,
                                      ),
                                      style: const ButtonStyle(
                                        minimumSize: WidgetStatePropertyAll(
                                          Size(
                                            0,
                                            0,
                                          ),
                                        ),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                    const Gap(
                                      BASE_SPACE * 2,
                                    ),
                                    Text(
                                      "Add new key",
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                                const Gap(
                                  BASE_SPACE * 4,
                                ),
                              ],
                            );
                          },
                        ),
                      Text(
                        "Label",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "Secret Key",
                        keyboardType: TextInputType.name,
                        controller: _labelController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter label for the key";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "Private Key",
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              final file = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pem'],
                              );
                              if (file == null) return;
                              File f = File(file.files.first.path!);
                              if (!f.existsSync()) return;

                              setState(
                                () {
                                  _keyController.text = f.readAsStringSync();
                                },
                              );
                            },
                            icon: Icon(
                              Icons.upload_file,
                            ),
                          )
                        ],
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "-----BEGIN RSA PRIVATE KEY-----",
                        minLines: 5,
                        maxLines: 8,
                        keyboardType: TextInputType.name,
                        controller: _keyController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter the private key";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      Text(
                        "Passphrase",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "******",
                        keyboardType: TextInputType.name,
                        controller: _passphraseController,
                        obscureText: !_passwordShown,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordShown ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordShown = !_passwordShown;
                            });
                          },
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      const Gap(
                        BASE_SPACE * 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = true;
                            });
                          }
                        },
                        child: _loading
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Add",
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
