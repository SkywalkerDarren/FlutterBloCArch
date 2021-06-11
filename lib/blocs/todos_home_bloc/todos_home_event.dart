part of 'todos_home_bloc.dart';

abstract class TodosHomeEvent extends Equatable {
  const TodosHomeEvent();
}

class TodoLocalUpdateEvent extends TodosHomeEvent {
  final List<TodoEntity> todos;

  TodoLocalUpdateEvent(this.todos);
  @override
  List<Object?> get props => [this.todos];
}
