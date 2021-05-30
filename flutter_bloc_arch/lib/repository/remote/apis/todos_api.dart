import 'package:dio/dio.dart';
import 'package:flutter_bloc_arch/repository/remote/http_base.dart';
import 'package:flutter_bloc_arch/repository/remote/req_resp/todo.dart';
import 'package:retrofit/retrofit.dart';

part 'todos_api.g.dart';

@RestApi(baseUrl: HttpBase.baseUrl)
abstract class TodosApi {
  factory TodosApi({Dio? dio}) => _TodosApi(dio ?? HttpBase.dio);

  @GET("/todos")
  Future<List<Todo>> getTodos();
}
