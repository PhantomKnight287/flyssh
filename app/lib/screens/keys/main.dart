import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/key.dart';
import 'package:flyssh/screens/keys/edit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class KeysScreen extends StatefulWidget {
  const KeysScreen({super.key});

  @override
  State<KeysScreen> createState() => _KeysScreenState();
}

class _KeysScreenState extends State<KeysScreen> {
  Future<List<SshKey>> fetchKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token")!;
    final req = await http.get(Uri.parse("$BACKEND_URL/keys"), headers: {"Authorization": "Token $token"});
    final body = jsonDecode(req.body) as List<dynamic>;
    return body.map((e) => SshKey(label: e['label'], id: e['id'], passphrase: e['passphrase'], value: e['value'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SshKey>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final key = snapshot.data![index];
                return ListTile(
                  title: Text(key.label),
                  tileColor: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabled: true,
                  onTap: () {
                    Get.to(
                      () => UpdateKeyScreen(
                        sshKey: key,
                      ),
                    );
                  },
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
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: snapshot.data!.length,
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "No Keys",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
      initialData: const [],
      future: fetchKeys(),
    );
  }
}
