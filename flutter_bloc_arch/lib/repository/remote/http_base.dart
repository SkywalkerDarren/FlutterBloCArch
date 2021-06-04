import 'package:dio/dio.dart';
import 'package:flutter_bloc_arch/repository/remote/interceptors/mock_interceptor.dart';

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

  static final Dio mockDio = Dio()
    ..interceptors.addAll([
      RequestLoggingInterceptor(),
      MockInterceptor(),
      ResponseLoggingInterceptor()
    ]);
}
