part of 'todos_home_bloc.dart';

abstract class TodosHomeState extends Equatable {
  const TodosHomeState();
}

class TodosHomeInitial extends TodosHomeState {
  @override
  List<Object> get props => [];
}

class TodosHomeUpdated extends TodosHomeState {
  final List<TodoViewState> todos;

  TodosHomeUpdated(this.todos);

  @override
  List<Object> get props => [this.todos];
}

class TodoViewState extends Equatable {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoViewState({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  @override
  List<Object?> get props => [
        this.userId,
        this.id,
        this.title,
        this.completed,
      ];
}
