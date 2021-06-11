import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_arch/presentation/router/app_router.dart';
import 'package:flutter_bloc_arch/repository/local/app_database.dart';

void main() {
  runZonedGuarded(() async {
    FlutterError.onError = (details) {
      log(
        'flutter onError',
        error: details.exception,
        stackTrace: details.stack,
      );
    };
    WidgetsFlutterBinding.ensureInitialized();
    await AppDatabase.initDatabase();
    runApp(MyApp());
  }, (error, stackTrace) {
    log(
      'flutter zoned error',
      error: error,
      stackTrace: stackTrace,
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyMaterialApp();
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
