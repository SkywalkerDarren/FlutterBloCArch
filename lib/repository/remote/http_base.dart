import 'package:dio/dio.dart';
import 'package:flutter_bloc_arch/repository/remote/interceptors/mock_interceptor.dart';
import 'package:flutter_bloc_arch/repository/remote/interceptors/replace_host_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

class HttpBase {
  static const String baseTodoUrl = 'https://baseTodoUrl.placeholder.com';

  static final Dio dio = Dio(BaseOptions(
    connectTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
    sendTimeout: 30 * 1000,
  ))
    ..interceptors.addAll([
      RequestLoggingInterceptor(),
      // place your interceptors to here
      MockInterceptor(),
      ReplaceHostInterceptor((baseUrl) => currentMap[baseUrl] ?? baseUrl),
      ResponseLoggingInterceptor()
    ]);

  static Map<String, String> get currentMap {
    // here handle url map
    return devMap;
  }

  // place your url with environment
  static const devMap = {
    baseTodoUrl: 'https://jsonplaceholder.typicode.com',
  };

  static const testMap = {
    baseTodoUrl: 'https://jsonplaceholder.typicode.com',
  };

  static const prodMap = {
    baseTodoUrl: 'https://jsonplaceholder.typicode.com',
  };
}
