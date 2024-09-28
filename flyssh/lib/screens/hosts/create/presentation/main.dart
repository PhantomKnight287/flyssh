import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/screens/hosts/service/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:flyssh/utils/error.dart';
import 'package:gap/gap.dart';
import 'package:openapi/openapi.dart';

class CreateHostsScreen extends StatefulWidget {
  const CreateHostsScreen({super.key});

  @override
  State<CreateHostsScreen> createState() => _CreateHostsScreenState();
}

class _CreateHostsScreenState extends State<CreateHostsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController(), _hostnameController = TextEditingController(), _usernameController = TextEditingController(), _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _createHost() async {
    if (!_formKey.currentState!.validate() || _loading) return;
    try {
      setState(() {
        _loading = true;
      });
      final req = await HostsService.createHost(
        CreateHostDto(
          (b) {
            b
              ..hostname = _hostnameController.text
              ..label = _labelController.text
              ..username = _usernameController.text
              ..password = _passwordController.text
              ..build();
          },
        ),
      );
      showSuccessToast(
        title: "Host Added",
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

  @override
  Widget build(BuildContext context) {
    bool _isPhone = isPhone(context);
    return Scaffold(
      appBar: _isPhone
          ? AppBar(
              title: const Text(
                "Add new host",
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
                                      "Add new host",
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
                      Row(
                        children: [
                          Text(
                            "Credentials",
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          OutlinedButton(
                            onPressed: () {},
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
                            ),
                            child: const Text(
                              "Use a key",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(
                        BASE_SPACE * 2,
                      ),
                      InputField(
                        hintText: "abandoned_project",
                        keyboardType: TextInputType.name,
                        controller: _passwordController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "Please enter login password or choose a key";
                          return null;
                        },
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
