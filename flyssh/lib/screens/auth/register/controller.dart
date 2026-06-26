import 'package:flutter/material.dart';
import 'package:flyssh/screens/auth/service.dart';
import 'package:flyssh/services/crypto.dart';
import 'package:flyssh/services/master_key.dart';
import 'package:flyssh/services/token.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterController extends ChangeNotifier {
  final AuthService authService;
  final TokenService tokenService;
  final MasterKeyService masterKeyService;
  final CryptoService cryptoService;

  RegisterController(this.authService, this.tokenService, this.masterKeyService, this.cryptoService);

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  void clearError() { _error = null; }

  bool _isPasswordShown = false;
  bool get isPasswordShown => _isPasswordShown;

  String? _masterKey;
  String? get masterKey => _masterKey;

  String? _recoveryKey;
  String? get recoveryKey => _recoveryKey;

  bool _registrationComplete = false;
  bool get registrationComplete => _registrationComplete;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    _isPasswordShown = !_isPasswordShown;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await authService.register(
        usernameController.text,
        passwordController.text,
        nameController.text,
      );
      _masterKey = result.masterKey;
      _recoveryKey = result.response.recoveryKey;
      await tokenService.setToken(result.response.token ?? '');
      await masterKeyService.setMasterKey(result.masterKey);

      // Encrypt the master key with the recovery key and store on server
      try {
        final encrypted = cryptoService.encrypt(
          result.masterKey,
          result.response.recoveryKey ?? '',
        );
        await authService.setupRecovery(
          '${encrypted.iv}:${encrypted.ciphertext}',
        );
      } catch (_) {
        // Recovery setup is best-effort; user still has the keys shown on screen
      }

      _registrationComplete = true;
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
