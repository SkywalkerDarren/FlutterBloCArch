import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_arch/blocs/todos_home_bloc/todos_home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => TodosHomeBloc(),
      ),
    ], child: HomeView(title: title));
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Builder(builder: (context) {
          final todos =
              context.select<TodosHomeBloc, List<TodoViewState>>((bloc) {
            final state = bloc.state;
            if (state is TodosHomeUpdated) {
              return state.todos;
            } else {
              return [];
            }
          });
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(todos[index].title),
              );
            },
          );
        }),
      ),
    );
  }
}
