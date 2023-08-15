// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_system_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorListSystemDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ListSystemDatabaseBuilder databaseBuilder(String name) =>
      _$ListSystemDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ListSystemDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ListSystemDatabaseBuilder(null);
}

class _$ListSystemDatabaseBuilder {
  _$ListSystemDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ListSystemDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ListSystemDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ListSystemDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ListSystemDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ListSystemDatabase extends ListSystemDatabase {
  _$ListSystemDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskAppDao? _taskAppDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `TaskApps` (`title` TEXT, `creationDate` TEXT, `updateDate` TEXT, `description` TEXT, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `isNecessarySaveInServer` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskAppDao get taskAppDao {
    return _taskAppDaoInstance ??= _$TaskAppDao(database, changeListener);
  }
}

class _$TaskAppDao extends TaskAppDao {
  _$TaskAppDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskAppInsertionAdapter = InsertionAdapter(
            database,
            'TaskApps',
            (TaskApp item) => <String, Object?>{
                  'title': item.title,
                  'creationDate': item.creationDate,
                  'updateDate': item.updateDate,
                  'description': item.description,
                  'id': item.id,
                  'isNecessarySaveInServer':
                      item.isNecessarySaveInServer ? 1 : 0
                }),
        _taskAppUpdateAdapter = UpdateAdapter(
            database,
            'TaskApps',
            ['id'],
            (TaskApp item) => <String, Object?>{
                  'title': item.title,
                  'creationDate': item.creationDate,
                  'updateDate': item.updateDate,
                  'description': item.description,
                  'id': item.id,
                  'isNecessarySaveInServer':
                      item.isNecessarySaveInServer ? 1 : 0
                }),
        _taskAppDeletionAdapter = DeletionAdapter(
            database,
            'TaskApps',
            ['id'],
            (TaskApp item) => <String, Object?>{
                  'title': item.title,
                  'creationDate': item.creationDate,
                  'updateDate': item.updateDate,
                  'description': item.description,
                  'id': item.id,
                  'isNecessarySaveInServer':
                      item.isNecessarySaveInServer ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskApp> _taskAppInsertionAdapter;

  final UpdateAdapter<TaskApp> _taskAppUpdateAdapter;

  final DeletionAdapter<TaskApp> _taskAppDeletionAdapter;

  @override
  Future<List<TaskApp>> fetchAll() async {
    return _queryAdapter.queryList('SELECT * FROM TaskApps',
        mapper: (Map<String, Object?> row) => TaskApp(
            id: row['id'] as int?,
            isNecessarySaveInServer:
                (row['isNecessarySaveInServer'] as int) != 0,
            title: row['title'] as String?,
            creationDate: row['creationDate'] as String?,
            updateDate: row['updateDate'] as String?,
            description: row['description'] as String?));
  }

  @override
  Future<TaskApp?> fetchById(int id) async {
    return _queryAdapter.query('SELECT * FROM TaskApps WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TaskApp(
            id: row['id'] as int?,
            isNecessarySaveInServer:
                (row['isNecessarySaveInServer'] as int) != 0,
            title: row['title'] as String?,
            creationDate: row['creationDate'] as String?,
            updateDate: row['updateDate'] as String?,
            description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM TaskApps');
  }

  @override
  Future<int> insertLocally(TaskApp object) {
    return _taskAppInsertionAdapter.insertAndReturnId(
        object, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateLocally(TaskApp object) {
    return _taskAppUpdateAdapter.updateAndReturnChangedRows(
        object, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteLocally(TaskApp object) {
    return _taskAppDeletionAdapter.deleteAndReturnChangedRows(object);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
