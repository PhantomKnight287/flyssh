import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/constants/main.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class TokenService {
  final _key = TOKEN_KEY;
  late final bool _usePlainPrefs;

  TokenService() {
    _usePlainPrefs = !kIsWeb && Platform.isMacOS;
  }

  Future<String> getToken() async {
    if (_usePlainPrefs) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_key) ?? "";
    }
    const storage = FlutterSecureStorage();
    return await storage.read(key: _key) ?? "";
  }

  Future<void> setToken(String token) async {
    if (_usePlainPrefs) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, token);
      return;
    }
    const storage = FlutterSecureStorage();
    await storage.write(key: _key, value: token);
  }

  Future<void> clearToken() async {
    if (_usePlainPrefs) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      return;
    }
    const storage = FlutterSecureStorage();
    await storage.delete(key: _key);
  }
}
