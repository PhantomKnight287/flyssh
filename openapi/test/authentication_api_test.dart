import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthenticationApi
void main() {
  final instance = Openapi().getAuthenticationApi();

  group(AuthenticationApi, () {
    // Login
    //
    // Login
    //
    //Future<LoginEntity> authControllerLogin(LoginDTO loginDTO) async
    test('test authControllerLogin', () async {
      // TODO
    });

    // Signup
    //
    // Signup
    //
    //Future<SignupEntity> authControllerRegister(SignupDTO signupDTO) async
    test('test authControllerRegister', () async {
      // TODO
    });

  });
}
