import 'package:dio/dio.dart';

class ApiResponse {
  static String toHumanMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        if (e.response?.statusCode == 400) {
          final errors = data['errors'] as Map<String, dynamic>?;
          if (errors != null && errors.isNotEmpty) {
            return errors.values.first?.toString() ?? data['message']?.toString() ?? 'Bad Request';
          }
          return data['message']?.toString() ?? 'Bad Request';
        }
        return data['message']?.toString() ?? 'An unknown error occurred';
      }
      return e.message ?? 'An unknown error occurred';
    } catch (_) {
      return e.message ?? 'An unknown error occurred';
    }
  }
}
