import 'package:floor/floor.dart';

@entity
class TodoEntity {
  final int userId;
  @primaryKey
  final int id;
  final String title;
  final bool completed;

  TodoEntity(this.userId, this.id, this.title, this.completed);
}
