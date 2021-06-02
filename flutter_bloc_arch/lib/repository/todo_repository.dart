import 'package:flutter_bloc_arch/core/utils/result.dart';
import 'package:flutter_bloc_arch/repository/local/app_database.dart';
import 'package:flutter_bloc_arch/repository/local/daos/todo_dao.dart';
import 'package:flutter_bloc_arch/repository/local/entities/todo_entity.dart';
import 'package:flutter_bloc_arch/repository/remote/apis/todos_api.dart';

class TodoRepository {
  TodoRepository._({required this.todosApi, required this.todoDao});

  static TodoRepository? _instance;

  final TodosApi todosApi;
  final TodoDao todoDao;

  factory TodoRepository.instance({
    TodosApi? todosApi,
    TodoDao? todoDao,
  }) {
    if (_instance == null) {
      _instance = TodoRepository._(
        todosApi: todosApi ?? TodosApi(),
        todoDao: todoDao ?? AppDatabase.instance.todoDao,
      );
    }
    return _instance!;
  }

  Stream<List<TodoEntity>> get todosStream => todoDao.findAllTodosAsStream();

  Future<Result<List<TodoEntity>>> fetchTodos() async {
    try {
      final todos = await todosApi.getTodos();
      final todoEntities = todos
          .map((todo) =>
              TodoEntity(todo.userId, todo.id, todo.title, todo.completed))
          .toList();
      await todoDao.insertAllTodo(todoEntities);
      return Result.success(todoEntities);
    } on Exception catch (e) {
      return Result.error(exception: e);
    } on Error catch (e) {
      return Result.error(error: e);
    }
  }

  Future<void> insertTodo(TodoEntity entity) async {
    await todoDao.insertTodo(entity);
  }

  Future<void> deleteTodo(TodoEntity entity) async {
    await todoDao.deleteTodo(entity);
  }
}
