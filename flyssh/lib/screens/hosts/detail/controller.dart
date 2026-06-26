import 'package:flutter/material.dart';
import 'package:flyssh/screens/hosts/service.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class HostDetailController extends ChangeNotifier {
  final HostService hostService;

  HostDetailController(this.hostService);

  HostsHostResponse? _host;
  HostsHostResponse? get host => _host;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _deleted = false;
  bool get deleted => _deleted;

  Future<void> loadHost(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _host = await hostService.getHost(id);
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteHost(String id) async {
    try {
      await hostService.deleteHost(id);
      _deleted = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }

  Future<String?> getDecryptedPassword() async {
    if (_host == null) return null;
    return await hostService.decryptPasswordAsync(_host!.password, _host!.iv);
  }
}
