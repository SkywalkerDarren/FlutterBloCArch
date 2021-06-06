import 'package:dio/dio.dart';
import 'package:flutter_bloc_arch/repository/remote/http_base.dart';
import 'package:flutter_bloc_arch/repository/remote/interceptors/replace_host_interceptor.dart';
import 'package:flutter_bloc_arch/repository/remote/req_resp/todo.dart';
import 'package:retrofit/retrofit.dart';

part 'todos_api.g.dart';

@RestApi(baseUrl: HttpBase.baseTodoUrl)
abstract class TodosApi {
  factory TodosApi({Dio? dio}) => _TodosApi(dio ?? HttpBase.dio);

  static const todos = '/todos';

  @GET(todos)
  @Extra({ReplaceHostInterceptor.REPLACE_HOST: true})
  Future<List<TodoResponse>> getTodos();
}
