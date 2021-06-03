import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_arch/repository/local/entities/todo_entity.dart';
import 'package:flutter_bloc_arch/repository/todo_repository.dart';

part 'todos_home_event.dart';
part 'todos_home_state.dart';

class TodosHomeBloc extends Bloc<TodosHomeEvent, TodosHomeState> {
  StreamSubscription? _todosSubscription;

  TodosHomeBloc({TodoRepository? todoRepository}) : super(TodosHomeInitial()) {
    _todosSubscription = (todoRepository ?? TodoRepository.instance())
        .todosStream
        .listen((todos) {
      add(TodoLocalUpdateEvent(todos));
    });
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<TodosHomeState> mapEventToState(
    TodosHomeEvent event,
  ) async* {
    if (event is TodoLocalUpdateEvent) {
      yield* mapTodoLocalUpdateEventToState(event);
    }
  }

  Stream<TodosHomeState> mapTodoLocalUpdateEventToState(
      TodoLocalUpdateEvent event) async* {
    final todos = event.todos.map((todo) {
      return TodoViewState(
          userId: todo.userId,
          id: todo.id,
          title: todo.title,
          completed: todo.completed);
    }).toList();
    yield TodosHomeUpdated(todos);
  }
}
