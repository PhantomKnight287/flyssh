import 'package:flutter/material.dart';
import 'package:flyssh/screens/auth/service.dart';
import 'package:flyssh/services/crypto.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecoverController extends ChangeNotifier {
  final AuthService authService;
  final CryptoService cryptoService;

  RecoverController(this.authService, this.cryptoService);

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final _recoveryKeyController = TextEditingController();
  TextEditingController get recoveryKeyController => _recoveryKeyController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _decryptedMasterKey;
  String? get decryptedMasterKey => _decryptedMasterKey;

  void clearError() { _error = null; }

  bool _recoveryComplete = false;
  bool get recoveryComplete => _recoveryComplete;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _recoveryKeyController.dispose();
    super.dispose();
  }

  Future<void> recover(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await authService.recover(
        usernameController.text,
        passwordController.text,
        recoveryKeyController.text,
      );
      // Decrypt the master key using the recovery key
      final encryptedBlob = response.encryptedMasterKey ?? '';
      final parts = encryptedBlob.split(':');
      if (parts.length == 2) {
        try {
          _decryptedMasterKey = cryptoService.decrypt(
            parts[1],
            parts[0],
            recoveryKeyController.text,
          );
        } catch (_) {
          _decryptedMasterKey = null;
          _error = 'Failed to decrypt master key. Invalid recovery key?';
          notifyListeners();
          return;
        }
      } else {
        _decryptedMasterKey = encryptedBlob;
      }
      _recoveryComplete = true;
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
