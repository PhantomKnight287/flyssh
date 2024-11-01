import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/components/bottom.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/key.dart';
import 'package:flyssh/screens/hosts/service/main.dart';
import 'package:flyssh/screens/keys/create/presentation/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flyssh/utils/error.dart';
import 'package:gap/gap.dart';
import 'package:openapi/openapi.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CreateHostsScreen extends StatefulWidget {
  const CreateHostsScreen({
    super.key,
    this.host,
  });
  final PartialHost? host;

  @override
  State<CreateHostsScreen> createState() => _CreateHostsScreenState();
}

class _CreateHostsScreenState extends State<CreateHostsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController(),
      _hostnameController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _portController = TextEditingController.fromValue(
        const TextEditingValue(
          text: '22',
        ),
      ),
      _keyController = TextEditingController();
  bool _loading = false;
  bool _passwordShown = false;
  KeyResponse? _selectedKey;

  Future<void> _createHost() async {
    if (!_formKey.currentState!.validate() || _loading) return;
    try {
      try {
        int.parse(_portController.text.trim());
      } catch (e) {
        showErrorToast("Invalid port");
        return;
      }
      setState(() {
        _loading = true;
      });
      const storage = FlutterSecureStorage();
      final encrypter = encrypt.Encrypter(
        AES(
          encrypt.Key.fromBase64(
            (await storage.read(
              key: MASTER_KEY_KEY,
            ))!,
          ),
        ),
      );
      final iv = widget.host != null
          ? encrypt.IV.fromBase64(
              widget.host!.iv,
            )
          : encrypt.IV.fromLength(16);
      if (widget.host != null) {
        await HostsService.updateHost(
          widget.host!.id,
          UpdateHostDto(
            (b) {
              b
                ..hostname = _hostnameController.text.trim()
                ..label = _labelController.text.trim().isNotEmpty ? _labelController.text.trim() : 'Host'
                ..username = _usernameController.text.trim()
                ..port = int.parse(_portController.text.trim())
                ..iv = iv.base64;
              if (_selectedKey != null) b.keyId = _selectedKey!.id;
              if (_passwordController.text.trim().isNotEmpty) {
                b.password = encrypter
                    .encrypt(
                      _passwordController.text.trim(),
                      iv: iv,
                    )
                    .base64;
              }
              b.build();
            },
          ),
        );
      } else {
        await HostsService.createHost(
          CreateHostDto(
            (b) {
              b
                ..hostname = _hostnameController.text.trim()
                ..label = _labelController.text.trim().isNotEmpty ? _labelController.text.trim() : 'Host'
                ..username = _usernameController.text.trim()
                ..port = int.parse(_portController.text.trim())
                ..iv = iv.base64;
              if (_selectedKey != null) b.keyId = _selectedKey!.id;
              if (_passwordController.text.trim().isNotEmpty) {
                b.password = encrypter
                    .encrypt(
                      _passwordController.text.trim(),
                      iv: iv,
                    )
                    .base64;
              }
              b.build();
            },
          ),
        );
      }
      showSuccessToast(
        title: "Host ${widget.host != null ? "Updated" : "Created"}",
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      showErrorToast(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _labelController.dispose();
    _hostnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Future<void> _prefillFields() async {
    _labelController.text = widget.host!.label;
    _hostnameController.text = widget.host!.hostname;
    _usernameController.text = widget.host!.username;
    _portController.text = widget.host!.port.toString();
    if (widget.host!.key != null) {
      _keyController.text = "Using Key: ${widget.host!.key!.label}";
      setState(() {
        _selectedKey = KeyResponse(
          id: widget.host!.key!.id,
          label: widget.host!.key!.label,
        );
      });
    }
    if (widget.host!.password != null) {
      const storage = FlutterSecureStorage();
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key.fromBase64((await storage.read(
            key: MASTER_KEY_KEY,
          ))!),
        ),
      );

      _passwordController.text = encrypter
          .decrypt64(
            widget.host!.password!,
            iv: encrypt.IV.fromBase64(
              widget.host!.iv,
            ),
          )
          .toString();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.host != null) {
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
                "${widget.host != null ? "Update" : "Create new"} host",
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
                                      "${widget.host != null ? "Update" : "Create new"} host",
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
                        hintText: "AWS money burner",
                        keyboardType: TextInputType.name,
                        controller: _labelController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter label for the host";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      Text(
                        "Hostname",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "420.420.69.69",
                        keyboardType: TextInputType.name,
                        controller: _hostnameController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter the hostname";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      Text(
                        "Port",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "22",
                        keyboardType: TextInputType.number,
                        controller: _portController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter the hostname";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
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
                        hintText: "abandoned_project",
                        keyboardType: TextInputType.name,
                        controller: _usernameController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter login username";
                          return null;
                        },
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      if (_selectedKey != null)
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "SSH Key",
                                  style: TextStyle(
                                    fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                _buildKeyButton(
                                  context,
                                  title: "Change key",
                                )
                              ],
                            ),
                            const Gap(
                              BASE_SPACE * 2,
                            ),
                            InputField(
                              hintText: "SSH Key",
                              keyboardType: TextInputType.name,
                              controller: _keyController,
                              obscureText: false,
                              enabled: _selectedKey == null,
                            ),
                            const Gap(
                              BASE_SPACE * 4,
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          if (_selectedKey == null) _buildKeyButton(context)
                        ],
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "abandoned_project",
                        keyboardType: TextInputType.name,
                        controller: _passwordController,
                        obscureText: !_passwordShown,
                        validator: (p0) {
                          if ((p0 == null || p0.isEmpty) && _selectedKey == null) return "Please enter login password or choose a key";
                          return null;
                        },
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
                        onPressed: _createHost,
                        child: _loading
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                widget.host != null ? "Update" : "Add",
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

  OutlinedButton _buildKeyButton(BuildContext context, {String title = "Use a key"}) {
    return OutlinedButton(
      onPressed: () {
        WoltModalSheet.show(
          context: context,
          pageListBuilder: (context) {
            return [
              WoltModalSheetPage(
                topBarTitle: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                isTopBarLayerAlwaysVisible: true,
                trailingNavBarWidget: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: Navigator.of(context).pop,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final response = await Navigator.of(context).push<KeyResponse>(
                            CupertinoModalPopupRoute(
                              builder: (context) => const CreateKeyScreen(),
                            ),
                          );
                          if (response != null) {
                            _keyController.text = "Using Key: ${response.label}";
                            setState(() {
                              _selectedKey = response;
                            });
                          }
                        },
                        child: const Text(
                          "Create new key",
                        ),
                      ),
                      const Gap(
                        BASE_SPACE * 4,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          WoltModalSheet.of(context).showAtIndex(2);
                        },
                        style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                            Colors.black,
                          ),
                        ),
                        child: const Text(
                          "Select existing key",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
        );
      },
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(
          Size(
            0,
            0,
          ),
        ), // Removes the minimum size constraint
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStatePropertyAll(
          BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: BASE_SPACE * 2,
            vertical: BASE_SPACE,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
