import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_bloc_arch/repository/local/daos/todo_dao.dart';
import 'package:flutter_bloc_arch/repository/local/entities/todo_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [TodoEntity])
abstract class AppDatabase extends FloorDatabase {
  static AppDatabase? _appDatabase;
  TodoDao get todoDao;

  static Future<void> initDatabase() async {
    _appDatabase =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  AppDatabase get appDatabase {
    if (_appDatabase == null) {
      throw Exception("you must call initDatabase() first");
    }
    return _appDatabase!;
  }
}
