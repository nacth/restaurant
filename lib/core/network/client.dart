import 'package:dio/dio.dart';
import 'package:restaurant/core/exception/api_exception.dart';

class ApiClient {
  static Dio instance({required String baseUrl}) {
    final client = Dio();

    client.options.connectTimeout = 10 * 1000;
    client.options.receiveTimeout = 10 * 1000;
    client.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    client.interceptors.add(ApiInterceptor());
    client.options.baseUrl = baseUrl;

    return client;
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}

typedef ClientReturn<T> = T Function();

Future<T> clientExecutor<T>({required ClientReturn<Future<T>> execute}) async {
  try {
    return await execute();
  } on DioError catch (error) {
    throw ApiException.parseError(error);
  }
}
