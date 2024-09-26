import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
