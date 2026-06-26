import 'package:dio/dio.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/services/master_key.dart';
import 'package:flyssh/services/token.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await getIt<TokenService>().getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await getIt<TokenService>().clearToken();
      await getIt<MasterKeyService>().clearMasterKey();
    }
    return handler.next(err);
  }
}
