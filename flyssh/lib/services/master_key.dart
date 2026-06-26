import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction over storage so macOS uses SharedPreferences
/// (Keychain requires Apple Developer account) while other platforms
/// use FlutterSecureStorage.
abstract class _KeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

class _SecureStore implements _KeyValueStore {
  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

class _PrefsStore implements _KeyValueStore {
  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<String?> read(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }

  @override
  Future<void> write(String key, String value) async {
    final prefs = await _getPrefs();
    await prefs.setString(key, value);
  }

  @override
  Future<void> delete(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }
}

@singleton
class MasterKeyService {
  static const _key = 'master_key';
  late final _KeyValueStore _store;

  MasterKeyService() {
    // macOS Keychain requires Apple Developer account; fall back to SharedPreferences
    final usePlainPrefs = !kIsWeb && Platform.isMacOS;
    _store = usePlainPrefs ? _PrefsStore() : _SecureStore();
  }

  Future<String?> getMasterKey() async {
    return _store.read(_key);
  }

  Future<void> setMasterKey(String masterKey) async {
    await _store.write(_key, masterKey);
  }

  Future<void> clearMasterKey() async {
    await _store.delete(_key);
  }

  Future<bool> hasMasterKey() async {
    final key = await getMasterKey();
    return key != null && key.isNotEmpty;
  }
}
