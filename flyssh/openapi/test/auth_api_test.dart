import 'package:test/test.dart';
import 'package:flyssh_api/flyssh_api.dart';


/// tests for AuthApi
void main() {
  final instance = FlysshApi().getAuthApi();

  group(AuthApi, () {
    // Login a user
    //
    // Authenticate a user with username, password and masterKeyHash. The client derives authKey = PBKDF2(masterKey, email) and sends it as masterKeyHash. The server verifies it against the stored bcrypt hash.
    //
    //Future<AuthLoginUserResponse> authLoginPost(AuthLoginUserRequest authLoginUserRequest) async
    test('test authLoginPost', () async {
      // TODO
    });

    // Recover encrypted master key
    //
    // Verify username, password, and recovery key, then return the encrypted master key blob. The client decrypts it locally. No JWT is issued — call /auth/login afterward.
    //
    //Future<AuthRecoverResponse> authRecoverPost(AuthRecoverRequest authRecoverRequest) async
    test('test authRecoverPost', () async {
      // TODO
    });

    // Store encrypted master key for recovery
    //
    // After registration, the client encrypts the raw master key using the recovery key (AES-GCM, client-side) and sends the encrypted blob to the server for storage.
    //
    //Future<ModelsGenericResponse> authRecoverySetupPost(AuthSetupRecoveryRequest authSetupRecoveryRequest) async
    test('test authRecoverySetupPost', () async {
      // TODO
    });

    // Register a new user
    //
    // Create a new user account. The client must generate a master key locally, derive an authKey via PBKDF2(masterKey, email), and send the authKey as masterKeyHash. The server never sees the raw master key.
    //
    //Future<AuthRegisterUserResponse> authRegisterPost(AuthRegisterUserRequest authRegisterUserRequest) async
    test('test authRegisterPost', () async {
      // TODO
    });

  });
}
