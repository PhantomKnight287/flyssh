import 'package:flutter/material.dart';
import 'package:flyssh/screens/keys/service.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class KeyListController extends ChangeNotifier {
  final KeyService keyService;

  KeyListController(this.keyService);

  List<KeysKeyResponse> _keys = [];
  List<KeysKeyResponse> get keys => _keys;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  void clearError() { _error = null; }

  Future<void> loadKeys() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _keys = await keyService.getKeys();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteKey(String id) async {
    try {
      await keyService.deleteKey(id);
      _keys.removeWhere((k) => k.id?.toString() == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }
}
