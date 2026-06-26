import 'package:dio/dio.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/services/crypto.dart';
import 'package:flyssh/utils/error.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  final _api = openapi.getAuthApi();
  final CryptoService cryptoService;

  AuthService(this.cryptoService);

  Future<AuthLoginUserResponse> login(
    String username,
    String password,
    String masterkey,
  ) async {
    try {
      final req = await _api.authLoginPost(
        authLoginUserRequest: AuthLoginUserRequest(
          masterKeyHash: cryptoService.deriveAuthKey(masterkey, username),
          password: password,
          username: username,
        ),
      );
      final res = req.data;
      if (res == null) {
        throw Exception('Failed to login');
      }
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<({AuthRegisterUserResponse response, String masterKey})> register(
    String username,
    String password,
    String name,
  ) async {
    try {
      final masterKey = cryptoService.generateMasterKey();
      final masterKeyHash = cryptoService.deriveAuthKey(masterKey, username);
      final req = await _api.authRegisterPost(
        authRegisterUserRequest: AuthRegisterUserRequest(
          masterKeyHash: masterKeyHash,
          name: name,
          password: password,
          username: username,
        ),
      );
      final res = req.data;
      if (res == null) {
        throw Exception('Failed to register');
      }
      return (response: res, masterKey: masterKey);
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<void> setupRecovery(String encryptedMasterKey) async {
    try {
      await _api.authRecoverySetupPost(
        authSetupRecoveryRequest: AuthSetupRecoveryRequest(
          encryptedMasterKey: encryptedMasterKey,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<AuthRecoverResponse> recover(
    String username,
    String password,
    String recoveryKey,
  ) async {
    try {
      final req = await _api.authRecoverPost(
        authRecoverRequest: AuthRecoverRequest(
          password: password,
          recoveryKey: recoveryKey,
          username: username,
        ),
      );
      final res = req.data;
      if (res == null) {
        throw Exception('Failed to recover');
      }
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }
}
