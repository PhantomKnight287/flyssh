import 'package:flutter/material.dart';
import 'package:flyssh/screens/keys/service.dart';
import 'package:injectable/injectable.dart';

@injectable
class KeyEditController extends ChangeNotifier {
  final KeyService keyService;

  KeyEditController(this.keyService);

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _labelController = TextEditingController();
  TextEditingController get labelController => _labelController;

  final _valueController = TextEditingController();
  TextEditingController get valueController => _valueController;

  final _passphraseController = TextEditingController();
  TextEditingController get passphraseController => _passphraseController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  void clearError() { _error = null; }

  bool _success = false;
  bool get success => _success;

  @override
  void dispose() {
    _labelController.dispose();
    _valueController.dispose();
    _passphraseController.dispose();
    super.dispose();
  }

  Future<void> loadKey(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final key = await keyService.getKey(id);
      _labelController.text = key.label ?? '';
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateKey(BuildContext context, String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await keyService.updateKey(
        id: id,
        label: _labelController.text,
        value: _valueController.text.isNotEmpty ? _valueController.text : null,
        passphrase: _passphraseController.text.isNotEmpty
            ? _passphraseController.text
            : null,
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
