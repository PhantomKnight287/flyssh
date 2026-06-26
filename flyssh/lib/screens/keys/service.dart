import 'package:dio/dio.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/services/crypto.dart';
import 'package:flyssh/services/master_key.dart';
import 'package:flyssh/utils/error.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class KeyService {
  final _api = openapi.getKeysApi();
  final CryptoService cryptoService;
  final MasterKeyService masterKeyService;

  KeyService(this.cryptoService, this.masterKeyService);

  Future<List<KeysKeyResponse>> getKeys() async {
    try {
      final req = await _api.keysGet(authorization: '');
      return req.data ?? [];
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<KeysKeyResponse> getKey(String id) async {
    try {
      final req = await _api.keysIdGet(authorization: '', id: int.parse(id));
      final res = req.data;
      if (res == null) throw Exception('Key not found');
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<KeysKeyResponse> createKey({
    required String label,
    required String value,
    String? passphrase,
  }) async {
    try {
      final masterKey = await masterKeyService.getMasterKey();
      if (masterKey == null) throw Exception('Master key not found');

      final encrypted = cryptoService.encrypt(value, masterKey);
      String? encryptedPassphrase;
      if (passphrase != null && passphrase.isNotEmpty) {
        // Use the same IV as the key value so decryption works with stored IV
        encryptedPassphrase =
            cryptoService.encryptWithIv(passphrase, masterKey, encrypted.iv);
      }

      final req = await _api.keysPost(
        authorization: '',
        keysCreateKeyRequest: KeysCreateKeyRequest(
          label: label,
          value: encrypted.ciphertext,
          iv: encrypted.iv,
          passphrase: encryptedPassphrase,
        ),
      );
      final res = req.data;
      if (res == null) throw Exception('Failed to create key');
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<KeysKeyResponse> updateKey({
    required String id,
    String? label,
    String? value,
    String? passphrase,
  }) async {
    try {
      final masterKey = await masterKeyService.getMasterKey();
      if (masterKey == null) throw Exception('Master key not found');

      String? encryptedValue;
      String? iv;
      String? encryptedPassphrase;

      if (value != null && value.isNotEmpty) {
        final encrypted = cryptoService.encrypt(value, masterKey);
        encryptedValue = encrypted.ciphertext;
        iv = encrypted.iv;
      }

      if (passphrase != null && passphrase.isNotEmpty) {
        // Use the same IV as the key value for passphrase
        final passphraseIv = iv ?? (await getKey(id)).iv;
        if (passphraseIv != null && passphraseIv.isNotEmpty) {
          encryptedPassphrase =
              cryptoService.encryptWithIv(passphrase, masterKey, passphraseIv);
        }
      }

      final req = await _api.keysIdPut(
        authorization: '',
        id: int.parse(id),
        keysUpdateKeyRequest: KeysUpdateKeyRequest(
          label: label,
          value: encryptedValue,
          iv: iv,
          passphrase: encryptedPassphrase,
        ),
      );
      final res = req.data;
      if (res == null) throw Exception('Failed to update key');
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<void> deleteKey(String id) async {
    try {
      await _api.keysIdDelete(authorization: '', id: int.parse(id));
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<String?> decryptValue(String? encryptedValue, String? iv) async {
    if (encryptedValue == null ||
        encryptedValue.isEmpty ||
        iv == null ||
        iv.isEmpty) {
      return null;
    }
    try {
      final masterKey = await masterKeyService.getMasterKey();
      if (masterKey == null) return null;
      return cryptoService.decrypt(encryptedValue, iv, masterKey);
    } catch (_) {
      return null;
    }
  }

  Future<String?> decryptPassphrase(
      String? encryptedPassphrase, String? iv) async {
    if (encryptedPassphrase == null ||
        encryptedPassphrase.isEmpty ||
        iv == null ||
        iv.isEmpty) {
      return null;
    }
    try {
      final masterKey = await masterKeyService.getMasterKey();
      if (masterKey == null) return null;
      return cryptoService.decrypt(encryptedPassphrase, iv, masterKey);
    } catch (_) {
      return null;
    }
  }
}
