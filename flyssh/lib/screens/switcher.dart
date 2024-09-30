import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/riverpod/user_provider.dart';
import 'package:flyssh/screens/auth/login/presentation/main.dart';
import 'package:flyssh/screens/hosts/list/presentation/main.dart';

class ScreensSwitcher extends ConsumerStatefulWidget {
  const ScreensSwitcher({super.key});

  @override
  ConsumerState<ScreensSwitcher> createState() => _ScreensSwitcherState();
}

class _ScreensSwitcherState extends ConsumerState<ScreensSwitcher> {
  bool _loading = false;

  final _authApi = openapi.getAuthenticationApi();
  Future<void> _hyrate() async {
    try {
      setState(() {
        _loading = true;
      });
      const storage = FlutterSecureStorage();
      final key = await storage.read(
        key: MASTER_KEY_KEY,
      );

      if (key == null) return;

      // dio interceptor will add auth token if present, big brain move
      final req = await _authApi.authControllerGetCurrentUser();
      final data = req.data!;

      ref.read(userNotifierProvider.notifier).login(
            data.username,
            data.name,
            key,
          );
    } catch (e) {
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _hyrate();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);

    if (_loading) {
      return const Scaffold(
        appBar: null,
        body: SafeArea(
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      );
    }
    if (user == null) return const LoginScreen();

    return const HostsScreen();
  }
}
