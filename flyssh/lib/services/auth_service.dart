import 'package:flyssh/constants/main.dart';
import 'package:flyssh_api/flyssh_api.dart';

class AuthService {
  Future<AuthRegisterUserResponse> register({
    required String name,
    required String username,
    required String password,
    required String masterKeyHash,
  }) async {
    final response = await openapi.getAuthApi().authRegisterPost(
          authRegisterUserRequest: AuthRegisterUserRequest(
            name: name,
            username: username,
            password: password,
            masterKeyHash: masterKeyHash,
          ),
        );
    return response.data!;
  }

  Future<AuthLoginUserResponse> login({
    required String username,
    required String password,
    required String masterKeyHash,
  }) async {
    final response = await openapi.getAuthApi().authLoginPost(
          authLoginUserRequest: AuthLoginUserRequest(
            username: username,
            password: password,
            masterKeyHash: masterKeyHash,
          ),
        );
    return response.data!;
  }

  Future<void> setupRecovery({
    required String token,
    required String encryptedMasterKey,
  }) async {
    await openapi.getAuthApi().authRecoverySetupPost(
          authSetupRecoveryRequest: AuthSetupRecoveryRequest(
            encryptedMasterKey: encryptedMasterKey,
          ),
          headers: {'Authorization': 'Bearer $token'},
        );
  }

  Future<AuthRecoverResponse> recover({
    required String username,
    required String password,
    required String recoveryKey,
  }) async {
    final response = await openapi.getAuthApi().authRecoverPost(
          authRecoverRequest: AuthRecoverRequest(
            username: username,
            password: password,
            recoveryKey: recoveryKey,
          ),
        );
    return response.data!;
  }
}
