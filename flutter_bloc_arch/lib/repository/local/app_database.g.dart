// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TodoEntity` (`userId` INTEGER NOT NULL, `id` INTEGER NOT NULL, `title` TEXT NOT NULL, `completed` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _todoEntityInsertionAdapter = InsertionAdapter(
            database,
            'TodoEntity',
            (TodoEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'id': item.id,
                  'title': item.title,
                  'completed': item.completed ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoEntity> _todoEntityInsertionAdapter;

  @override
  Future<List<TodoEntity>> findAllTodos() async {
    return _queryAdapter.queryList('SELECT * FROM TodoEntity',
        mapper: (Map<String, Object?> row) => TodoEntity(
            row['userId'] as int,
            row['id'] as int,
            row['title'] as String,
            (row['completed'] as int) != 0));
  }

  @override
  Stream<TodoEntity?> findTodoById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM TodoEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TodoEntity(
            row['userId'] as int,
            row['id'] as int,
            row['title'] as String,
            (row['completed'] as int) != 0),
        arguments: [id],
        queryableName: 'TodoEntity',
        isView: false);
  }

  @override
  Future<void> insertTodo(TodoEntity entity) async {
    await _todoEntityInsertionAdapter.insert(entity, OnConflictStrategy.abort);
  }
}
