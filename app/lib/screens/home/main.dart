import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/host.dart';
import 'package:flyssh/models/key.dart';
import 'package:flyssh/screens/hosts/add.dart';
import 'package:flyssh/screens/hosts/edit.dart';
import 'package:flyssh/screens/hosts/ssh.dart';
import 'package:flyssh/screens/keys/add.dart';
import 'package:flyssh/screens/keys/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  Future<List<Host>> fetchHosts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token")!;
    final req = await http.get(Uri.parse("$BACKEND_URL/hosts"), headers: {"Authorization": "Token $token"});
    final body = jsonDecode(req.body) as List<dynamic>;
    final res = body
        .map(
          (e) => Host(
              hostname: e['hostname'],
              username: e['username'],
              label: e['label'],
              password: e['password'],
              id: e['id'],
              sshKey: e['key'] != null ? SshKey(id: e["key"], label: e["key__label"], passphrase: e["key__passphrase"], value: e["key__value"]) : null),
        )
        .toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (value) {
          setState(() {
            activeIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.terminal),
            label: "Hosts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.key),
            label: "Keys",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (activeIndex == 0) {
            Get.to(() => const AddHostScreen(), transition: Transition.rightToLeftWithFade)?.then((value) => setState(() {}));
          } else {
            Get.to(() => const AddKeyScreen(), transition: Transition.rightToLeftWithFade)?.then((value) => setState(() {}));
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          activeIndex == 0 ? "Hosts" : "Keys",
        ),
        centerTitle: false,
      ),
      body: activeIndex == 0
          ? FutureBuilder<List<Host>>(
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
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final host = snapshot.data![index];

                        return ListTile(
                          title: Text(host.label ?? host.hostname),
                          tileColor: Colors.grey.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          subtitle: Text(
                            "ssh, ${host.username}",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          enabled: true,
                          onTap: () {
                            Get.to(
                              () => SshScreen(
                                username: host.username,
                                address: host.hostname,
                                label: host.label,
                                password: host.password,
                                id: host.id,
                              ),
                            );
                          },
                          onLongPress: () {
                            Get.to(
                              () => UpdateHostScreen(
                                host: host,
                              ),
                            )?.then((value) => setState(() {}));
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.terminal),
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
                }
                return const SizedBox();
              },
              initialData: const [],
              future: fetchHosts(),
            )
          : const KeysScreen(),
    );
  }
}
