import 'package:dio/dio.dart';
import 'package:restaurant/core/network/response/error_response.dart';

class ApiException implements Exception {
  final ErrorResponse? response;
  final DioError? error;

  ApiException(this.response, this.error);

  String toString() => "ApiException";

  static DioError parseError(DioError error) {
    if (error.type == DioErrorType.response) {
      throw ApiException(
        error.response?.data is Map
            ? ErrorResponse.fromJson(
                error.response?.data,
              )
            : null,
        error,
      );
    }
    throw ApiException(null, error);
  }
}
