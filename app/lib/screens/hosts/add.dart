import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddHostScreen extends StatefulWidget {
  const AddHostScreen({super.key});

  @override
  State<AddHostScreen> createState() => _AddHostScreenState();
}

class _AddHostScreenState extends State<AddHostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _labelController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool loading = false;
  SshKey? selectedKey;
  List<SshKey> keys = [];

  Future<void> fetchKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token")!;
    final req = await http.get(Uri.parse("$BACKEND_URL/keys"), headers: {"Authorization": "Token $token"});
    final body = jsonDecode(req.body) as List<dynamic>;
    keys = body.map((e) => SshKey(label: e['label'], id: e['id'], passphrase: e['passphrase'], value: e['value'])).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchKeys();
  }

  void _createHost() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    if (_passwordController.text.isEmpty && selectedKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter either password or select a key."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token")!;
    final masterKey = prefs.getString("master_key")!;
    Map<String, dynamic> payload = {
      "username": _usernameController.text,
      "label": _labelController.text,
      "hostname": _addressController.text,
      "master_key": masterKey,
    };

    if (selectedKey == null) {
      payload["password"] = _passwordController.text;
    } else {
      payload["key_id"] = selectedKey!.id;
    }
    final req = await http.post(Uri.parse("$BACKEND_URL/hosts"), headers: {"Authorization": "Token $token", "Content-Type": "application/json"}, body: jsonEncode(payload));
    setState(() {
      loading = false;
    });
    final body = jsonDecode(req.body);
    if (req.statusCode != 200 && req.statusCode != 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(body['message'] ?? "Failed to create host."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New host created"),
        backgroundColor: Colors.green,
      ),
    );
    Get.back();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _labelController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Host",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: !loading ? _createHost : null,
            icon: !loading
                ? const Icon(
                    Icons.check,
                    color: Colors.greenAccent,
                  )
                : const CircularProgressIndicator(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Label",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hintText: "Staging",
                    keyboardType: TextInputType.name,
                    controller: _labelController,
                    fillColor: const Color(0xff1f1e21),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.greenAccent,
                        width: 1,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your host\'s label';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Ip or Hostname",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hintText: "192.168.1.2",
                    keyboardType: TextInputType.name,
                    controller: _addressController,
                    fillColor: const Color(0xff1f1e21),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your host\'s ip or hostname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Connection Username",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hintText: "phantom",
                    keyboardType: TextInputType.name,
                    controller: _usernameController,
                    fillColor: const Color(0xff1f1e21),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your connection username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Connection Password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hintText: "*******",
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    maxLines: 1,
                    obscureText: !isPasswordVisible,
                    fillColor: const Color(0xff1f1e21),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height / 2.25,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                                    child: Center(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          final key = keys[index];
                                          return ListTile(
                                            title: Text(key.label),
                                            tileColor: Colors.grey.shade900,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            enabled: true,
                                            onTap: () {
                                              setState(() {
                                                selectedKey = key;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            onLongPress: () {},
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              child: const Icon(Icons.key),
                                            ),
                                          );
                                        },
                                        itemCount: keys.length,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.grey.shade600),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                                return const EdgeInsets.symmetric(vertical: 1, horizontal: 10);
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Text(
                            selectedKey == null ? "Select Key" : selectedKey!.label,
                          ),
                        ),
                      ),
                      if (selectedKey != null)
                        const SizedBox(
                          width: 10,
                        ),
                      if (selectedKey != null)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedKey = null;
                            });
                          },
                          child: const Icon(Icons.close),
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.red),
                            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                                return const EdgeInsets.symmetric(vertical: 1, horizontal: 10);
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: Colors.grey.shade600,
                                    width: 1,
                                  )),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
