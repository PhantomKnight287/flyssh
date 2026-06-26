import 'package:flutter/material.dart';
import 'package:flyssh/screens/auth/service.dart';
import 'package:flyssh/services/master_key.dart';
import 'package:flyssh/services/token.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginController extends ChangeNotifier {
  final AuthService authService;
  final TokenService tokenService;
  final MasterKeyService masterKeyService;

  LoginController(this.authService, this.tokenService, this.masterKeyService);

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final _masterkeyController = TextEditingController();
  TextEditingController get masterkeyController => _masterkeyController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  void clearError() { _error = null; }

  bool _isPasswordShown = false;
  bool get isPasswordShown => _isPasswordShown;

  void togglePasswordVisibility() {
    _isPasswordShown = !_isPasswordShown;
    notifyListeners();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _masterkeyController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await authService.login(
        usernameController.text,
        passwordController.text,
        masterkeyController.text,
      );
      await tokenService.setToken(response.token ?? '');
      await masterKeyService.setMasterKey(masterkeyController.text);
      if (context.mounted) {
        context.go('/hosts');
      }
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
