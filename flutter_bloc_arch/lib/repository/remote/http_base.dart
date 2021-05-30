import 'package:dio/dio.dart';

import 'interceptors/logging_interceptor.dart';

class HttpBase {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static final Dio dio = Dio(BaseOptions(
    connectTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
    sendTimeout: 30 * 1000,
  ))
    ..interceptors.addAll([
      RequestLoggingInterceptor(),
      // place your interceptors to here
      ResponseLoggingInterceptor()
    ]);
}
