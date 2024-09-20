import 'package:flutter/material.dart';
import 'package:flyssh/screens/auth/login.dart';
import 'package:flyssh/screens/home/main.dart';
import 'package:flyssh/screens/keys/main.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Center(
                child: Text(
              'FlySSH',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            )),
          ),
          ListTile(
            title: const Text('Keys'),
            onTap: () {
              Get.to(() => const KeysScreen());
            },
          ),
        ],
      ),
    );
  }
}
