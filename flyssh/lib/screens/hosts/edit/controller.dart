import 'package:flutter/material.dart';
import 'package:flyssh/screens/hosts/service.dart';
import 'package:flyssh/screens/keys/service.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class HostEditController extends ChangeNotifier {
  final HostService hostService;
  final KeyService keyService;

  HostEditController(this.hostService, this.keyService);

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _labelController = TextEditingController();
  TextEditingController get labelController => _labelController;

  final _hostnameController = TextEditingController();
  TextEditingController get hostnameController => _hostnameController;

  final _portController = TextEditingController();
  TextEditingController get portController => _portController;

  final _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  void clearError() { _error = null; }

  bool _success = false;
  bool get success => _success;

  List<KeysKeyResponse> _keys = [];
  List<KeysKeyResponse> get keys => _keys;

  int? _selectedKeyId;
  int? get selectedKeyId => _selectedKeyId;

  @override
  void dispose() {
    _labelController.dispose();
    _hostnameController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void setSelectedKeyId(int? id) {
    _selectedKeyId = id;
    notifyListeners();
  }

  Future<void> loadHost(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final host = await hostService.getHost(id);
      _labelController.text = host.label ?? '';
      _hostnameController.text = host.hostname ?? '';
      _portController.text = (host.port ?? 22).toString();
      _usernameController.text = host.username ?? '';
      _selectedKeyId = host.keyId;
      _keys = await keyService.getKeys();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateHost(BuildContext context, String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await hostService.updateHost(
        id: id,
        label: _labelController.text,
        hostname: _hostnameController.text,
        username: _usernameController.text,
        port: int.tryParse(_portController.text) ?? 22,
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : null,
        keyId: _selectedKeyId,
      );
      _success = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
