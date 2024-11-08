import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/components/bottom.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/key.dart';
import 'package:flyssh/screens/keys/service/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flyssh/utils/error.dart';
import 'package:gap/gap.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:openapi/openapi.dart';

class CreateKeyScreen extends StatefulWidget {
  const CreateKeyScreen({
    super.key,
    this.sshKey,
  });
  final PartialKey? sshKey;

  @override
  State<CreateKeyScreen> createState() => _CreateKeyScreenState();
}

class _CreateKeyScreenState extends State<CreateKeyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController(), _keyController = TextEditingController(), _passphraseController = TextEditingController();
  bool _loading = false;
  bool _passwordShown = false;

  Future<void> _createKey() async {
    if (!_formKey.currentState!.validate() || _loading) return;
    try {
      setState(() {
        _loading = true;
      });
      const storage = FlutterSecureStorage();
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key.fromBase64(
            (await storage.read(
              key: MASTER_KEY_KEY,
            ))!,
          ),
        ),
      );
      final iv = widget.sshKey != null ? encrypt.IV.fromBase64(widget.sshKey!.iv) : encrypt.IV.fromLength(16);
      GenericResponseDto req;
      if (widget.sshKey != null) {
        req = await KeysService.updateKey(widget.sshKey!.id, UpdateKeyDTO(
          (b) {
            b
              ..label = _labelController.text.trim().isNotEmpty ? _labelController.text.trim() : 'Key'
              ..passphrase = _passphraseController.text.trim().isNotEmpty
                  ? encrypter
                      .encrypt(
                        _passphraseController.text.trim(),
                        iv: iv,
                      )
                      .base64
                  : null
              ..value = encrypter
                  .encrypt(
                    _keyController.text.trim(),
                    iv: iv,
                  )
                  .base64
              ..build();
          },
        ));
      } else {
        req = await KeysService.createKey(
          CreateKeyDTO(
            (b) {
              b
                ..label = _labelController.text.trim()
                ..passphrase = _passphraseController.text.trim().isNotEmpty
                    ? encrypter
                        .encrypt(
                          _passphraseController.text.trim(),
                          iv: iv,
                        )
                        .base64
                    : null
                ..value = encrypter
                    .encrypt(
                      _keyController.text.trim(),
                      iv: iv,
                    )
                    .base64
                ..iv = iv.base64
                ..build();
            },
          ),
        );
      }
      showSuccessToast(
        title: "Key ${widget.sshKey != null ? "Updated" : "Created"}",
      );
      if (mounted) {
        Navigator.pop(
          context,
          KeyResponse(
            id: req.id,
            label: _labelController.text.trim(),
          ),
        );
      }
    } catch (e) {
      showErrorToast(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _prefillFields() async {
    _labelController.text = widget.sshKey!.label;
    const storage = FlutterSecureStorage();
    final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key.fromBase64(
        (await storage.read(
          key: MASTER_KEY_KEY,
        ))!,
      ),
    ));
    final iv = encrypt.IV.fromBase64(
      widget.sshKey!.iv,
    );

    _keyController.text = encrypter.decrypt64(
      widget.sshKey!.value,
      iv: iv,
    );
    if (widget.sshKey!.passphrase != null) {
      _passphraseController.text = encrypter.decrypt64(
        widget.sshKey!.passphrase!,
        iv: iv,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.sshKey != null) {
      _prefillFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isPhone = isPhone();
    return Scaffold(
      appBar: _isPhone
          ? AppBar(
              title: Text(
                "${widget.sshKey != null ? "Update" : "Create new"} key",
              ),
              centerTitle: false,
              bottom: Bottom(context),
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
                                      tooltip: "Back",
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
                                      "${widget.sshKey != null ? "Update" : "Create new"} key",
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
                          const Spacer(),
                          IconButton(
                            tooltip: "Upload private key",
                            style: const ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(
                                Size(
                                  0,
                                  0,
                                ),
                              ), // Removes the minimum size constraint
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
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
                            icon: const Icon(
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
                        onPressed: _createKey,
                        child: _loading
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                widget.sshKey != null ? "Update" : "Add",
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
