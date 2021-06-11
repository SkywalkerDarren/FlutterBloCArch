import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_arch/blocs/todos_home_bloc/todos_home_bloc.dart';
import 'package:flutter_bloc_arch/presentation/widgets/should_rebuild_widget.dart';

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
          return TestWidget(todos);
        }),
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  final List<TodoViewState> todos;

  TestWidget(this.todos);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      print("try update");
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (BuildContext context, int index) {
        return ShouldRebuild(
          child: TestUpdateWidget(widget.todos[index]),
          shouldRebuild: (a, b) {
            if (a is TestUpdateWidget && b is TestUpdateWidget)
              return a.todo != b.todo;
            else
              return true;
          },
        );
      },
    );
  }
}

class TestUpdateWidget extends StatefulWidget {
  final TodoViewState todo;

  TestUpdateWidget(this.todo);

  @override
  _TestUpdateWidgetState createState() => _TestUpdateWidgetState();
}

class _TestUpdateWidgetState extends State<TestUpdateWidget> {
  @override
  Widget build(BuildContext context) {
    print('update: ${widget.todo.title}');
    return ListTile(
      title: Text(widget.todo.title),
    );
  }
}
