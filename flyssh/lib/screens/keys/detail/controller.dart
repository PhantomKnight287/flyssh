import 'package:flutter/material.dart';
import 'package:flyssh/screens/keys/service.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class KeyDetailController extends ChangeNotifier {
  final KeyService keyService;

  KeyDetailController(this.keyService);

  KeysKeyResponse? _key;
  KeysKeyResponse? get sshKey => _key;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _deleted = false;
  bool get deleted => _deleted;

  Future<void> loadKey(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _key = await keyService.getKey(id);
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
      _deleted = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }
}
