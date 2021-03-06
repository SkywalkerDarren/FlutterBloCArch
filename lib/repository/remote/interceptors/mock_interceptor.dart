import 'package:dio/dio.dart';

class MockInterceptor extends Interceptor {
  static const MOCK_TAG = 'mock_tag';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == 'TodosApi.todos') {
      print('mocking path: ${options.path}');
      options.extra[MOCK_TAG] = true;
      handler.resolve(Response(
        requestOptions: options,
        data: [
          {
            "userId": 1234,
            "id": 1234,
            "title": "asdfasdf",
            "completed": true,
          },
        ],
        statusCode: 200,
      ));
    } else {
      handler.next(options);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
