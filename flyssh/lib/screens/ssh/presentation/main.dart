import 'package:async_builder/async_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/screens/ssh/service/main.dart';

class SshScreen extends StatefulWidget {
  const SshScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<SshScreen> createState() => SshScreenState();
}

class SshScreenState extends State<SshScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: AsyncBuilder(
          future: HostService.getHostInfo(
            widget.id,
          ),
          builder: (context, value) {
            print(value);
            return Column();
          },
          error: (context, error, stackTrace) {
            print(stackTrace);
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
          waiting: (context) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
