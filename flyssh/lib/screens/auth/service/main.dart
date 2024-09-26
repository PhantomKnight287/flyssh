import 'package:dio/dio.dart';
import 'package:error_or/error_or.dart';
import 'package:flyssh/constants/main.dart';
import 'package:openapi/openapi.dart';

final _authApi = openapi.getAuthenticationApi();

class AuthenticationService {
  static Future<ErrorOr<Response<LoginEntity>?>> login(LoginDTO body) async {
    try {
      final response = ErrorOr.value(await _authApi.authControllerLogin(loginDTO: body));
      return response;
    } catch (e) {
      return ErrorOr.error(e);
    }
  }
//  static Future<ErrorOr<Response<Siug>?>> signUp(SignupDTO body) async {
//     try {
//       final response = ErrorOr.value(await _authApi.authControllerRegister(signupDTO: body));
//       return response;
//     } catch (e) {
//       return ErrorOr.error(e);
//     }
//   }

  static Future<SignupEntity?> signUp(SignupDTO body) => _authApi.authControllerRegister(signupDTO: body).then((res) => res.data);
}
