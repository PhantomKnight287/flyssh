import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyssh/components/custom_cupertino_route.dart';
import 'package:flyssh/components/input.dart';
import 'package:flyssh/screens/hosts/list/presentation/main.dart';

class MasterKeyScreen extends StatefulWidget {
  final String masterKey;
  const MasterKeyScreen({
    super.key,
    required this.masterKey,
  });

  @override
  State<MasterKeyScreen> createState() => _MasterKeyScreenState();
}

class _MasterKeyScreenState extends State<MasterKeyScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.masterKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Master Key",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "You cannot login without this key. We recommend you keep it somewhere safe like your password manager.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    readOnly: true,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.copy,
                      ),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text: widget.masterKey,
                          ),
                        );

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Master Key copied to clipboard."),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        CustomCupertinoRoute(
                          builder: (context) {
                            return const HostsScreen();
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
                        (Set<WidgetState> states) {
                          return const EdgeInsets.all(15);
                        },
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
