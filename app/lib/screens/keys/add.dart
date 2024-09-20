import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flyssh/components/input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flyssh/constants/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddKeyScreen extends StatefulWidget {
  const AddKeyScreen({super.key});

  @override
  State<AddKeyScreen> createState() => _AddKeyScreenState();
}

class _AddKeyScreenState extends State<AddKeyScreen> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _passPhraseController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool passPhraseVisible = false;
  bool loading = false;

  Future<void> _createKey() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token")!;
    final masterKey = prefs.getString("master_key");
    final req = await http.post(Uri.parse("$BACKEND_URL/keys"),
        headers: {"Authorization": "Token $token", "Content-Type": "application/json"},
        body: jsonEncode({
          "label": _nameController.text,
          "passphrase": _passPhraseController.text,
          "value": _valueController.text,
          "master_key": masterKey,
        }));
    setState(() {
      loading = false;
    });
    final body = jsonDecode(req.body);
    if (req.statusCode != 200 && req.statusCode != 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(body['message'] ?? "Failed to create key."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New key created"),
        backgroundColor: Colors.green,
      ),
    );
    Get.back();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _passPhraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Key"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: !loading ? _createKey : null,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller: _nameController,
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
                        return 'Please enter your key\'s label';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Passphrase",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hintText: "******",
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passPhraseController,
                    obscureText: !passPhraseVisible,
                    maxLines: 1,
                    fillColor: const Color(0xff1f1e21),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.greenAccent,
                        width: 1,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passPhraseVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          passPhraseVisible = !passPhraseVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles();
                          if (result != null) {
                            File file = File(result.files.single.path!);
                            final data = await file.readAsString();
                            _valueController.text = data;
                          }
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
                        child: const Text("Upload"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hintText: "-----BEGIN RSA PRIVATE KEY-----",
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    controller: _valueController,
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
                        return 'Please enter your key\'s value';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
