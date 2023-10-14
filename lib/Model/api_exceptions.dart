import 'package:dio/dio.dart';

class APIException {
  List<String> getExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return [
          'Bad Response',
          'Invalid parameters',
        ];
      case DioExceptionType.connectionError:
        return [
          'Connection Error',
          'Please check your internet connection',
        ];
      case DioExceptionType.connectionTimeout:
        return [
          'Connection Error',
          'Please check your internet connection',
        ];
      case DioExceptionType.cancel:
        return [
          'Request Cancelled',
          'Please try again',
        ];
      case DioExceptionType.receiveTimeout:
        return [
          'Recieve Timeout',
          'Please check your internet connection',
        ];
      default:
        return [
          'Network Error',
          'Please check your internet connection',
        ];
    }
  }
}
