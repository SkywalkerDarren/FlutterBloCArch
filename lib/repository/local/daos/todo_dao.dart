import 'package:floor/floor.dart';
import 'package:flutter_bloc_arch/repository/local/entities/todo_entity.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM TodoEntity')
  Future<List<TodoEntity>> findAllTodos();

  @Query('SELECT * FROM TodoEntity')
  Stream<List<TodoEntity>> findAllTodosAsStream();

  @Query('SELECT * FROM TodoEntity WHERE id = :id')
  Stream<TodoEntity?> findTodoById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodo(TodoEntity entity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllTodo(List<TodoEntity> entities);

  @delete
  Future<void> deleteTodo(TodoEntity entity);
}
