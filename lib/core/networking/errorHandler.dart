import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handle(DioException e) {
    // Handle API response errors
    final responseData = e.response?.data;

    if (responseData is Map) {
      // Validation errors
      final errors = responseData['errors'];

      if (errors is Map && errors.isNotEmpty) {
        final firstError = errors.values.first;

        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }

        return firstError.toString();
      }

      // API message
      final message = responseData['message'];

      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }
    }

    // Handle Dio errors
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again.';

      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';

      case DioExceptionType.connectionError:
        return 'No internet connection.';

      case DioExceptionType.badCertificate:
        return 'Secure connection failed.';

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response?.statusCode);

      case DioExceptionType.unknown:
        return 'Something went wrong. Please try again.';
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';

      case 401:
        return 'Invalid email or password.';

      case 403:
        return 'You do not have permission.';

      case 404:
        return 'The requested resource was not found.';

      case 422:
        return 'Please check your entered data.';

      case 500:
        return 'Server error. Please try again later.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}