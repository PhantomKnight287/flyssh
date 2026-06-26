import 'package:flutter/material.dart';
import 'package:flyssh/screens/hosts/service.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class HostListController extends ChangeNotifier {
  final HostService hostService;

  HostListController(this.hostService);

  List<HostsHostResponse> _hosts = [];
  List<HostsHostResponse> get hosts => _hosts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  void clearError() { _error = null; }

  Future<void> loadHosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _hosts = await hostService.getHosts();
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
      _hosts.removeWhere((h) => h.id?.toString() == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }
}
