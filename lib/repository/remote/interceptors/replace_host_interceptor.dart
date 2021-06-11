import 'package:dio/dio.dart';

class ReplaceHostInterceptor extends Interceptor {
  static const REPLACE_HOST = 'replace_host';
  String Function(String)? replace;

  ReplaceHostInterceptor([this.replace]);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (replace != null && options.extra[REPLACE_HOST] == true) {
      options.baseUrl = replace!(options.baseUrl);
    }
    handler.next(options);
  }
}
