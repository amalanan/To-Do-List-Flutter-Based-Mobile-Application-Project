import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolistgsg/imports.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static const String _dbName = 'tasks.db';
  static const int _dbVersion = 1;

  static const String tableTasks = 'tasks';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnCompleted = 'completed';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableTasks(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnCompleted INTEGER NOT NULL
      )
    ''');
  }
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      tableTasks,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update(
      tableTasks,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableTasks);

    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        taskName: maps[i]['name'],
        taskCompleted: maps[i]['completed'] == 1,
      );
    });
  }
  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert(
      tableTasks,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
