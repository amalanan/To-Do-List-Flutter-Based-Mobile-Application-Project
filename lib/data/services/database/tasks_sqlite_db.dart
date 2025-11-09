import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';

class TasksSqliteDb {
  //sqlite db
  static Database? _database; //database
  static const String dbName = 'app.db'; //database name
  static const String tableName = 'tasks'; //table name
  static const String usersTable = 'users';

  static Future<void> clearAllTables() async {
    //clear all tables
    if (_database != null) {
      //if the database is not null
      await _database!.delete(tableName); //delete the table
      await _database!.delete(usersTable); //delete the table
    }
  }

  static Future<void> _createUsersTable(Database db) async {
    //create the users table
    await db.execute(''' //create the users table
    CREATE TABLE $usersTable ( //create the users table
      id INTEGER PRIMARY KEY, 
      username TEXT,
      email TEXT,
      firstName TEXT,
      lastName TEXT,
      gender TEXT,
      image TEXT,
      accessToken TEXT,
      refreshToken TEXT
    )
  ''');
  }

  static Future<void> init() async {
    //initialize the database
    final dbPath = await getDatabasesPath(); //get the database path
    final path = join(
      dbPath,
      dbName,
    ); //join the database path with the database name

    _database = await openDatabase(
      //open the database
      path, //path to the database
      version: 3, //version of the database
      onCreate: (db, version) async {
        //create the database
        await db.execute(''' //create the tasks table
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            completed INTEGER,
            userId INTEGER
          )
        ''');
        await _createUsersTable(db); //create the users table
      }, //create the database
      onUpgrade: (db, oldVersion, newVersion) async {
        //on upgrade
        if (oldVersion < 3) {
          //if the old version is less than 3
          await _createUsersTable(db); //create the users table
        }
      },
    );
  }

  static Future<int> insertUser(UserModel user) async {
    //insert the user
    return await _database!.insert(
      //insert the user
      usersTable, //table name
      {
        'id': user.id,
        'username': user.username,
        'email': user.email,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'image': user.image,
        'accessToken': user.accessToken,
        'refreshToken': user.refreshToken,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, //conflict algorithm
      //if the user already exists, replace it
    );
  }

  static Map<String, dynamic> _taskToMap(TaskModel task) {
    //convert the task to a map
    return {
      //return the task as a map
      'id': task.id,
      'name': task.taskName,
      'completed': task.taskCompleted ? 1 : 0,
      'userId': task.userId,
    }; //return the task as a map
  }

  static Future<int> insertTask(TaskModel task) async {
    //insert the task
    return await _database!.insert(
      //insert the task
      tableName, //table name
      _taskToMap(task), //task as a map
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); //if the task already exists, replace it
  }

  static Future<void> insertOrIgnore(TaskModel task) async {
    //insert or ignore the task
    await _database!.insert(
      //insert or ignore the task
      tableName,
      _taskToMap(task), //task as a map
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    //if the task already exists, ignore it
  }

  static Future<List<TaskModel>> getTasksForUser(int userId) async {
    //get the tasks for the user
    final List<Map<String, dynamic>> maps = await _database!.query(
      //get the tasks for the user
      tableName,
      where: 'userId = ?', //where clause to filter the tasks
      whereArgs: [userId], // where clause arguments to filter the tasks
    );
    return List.generate(
      //generate the tasks
      maps.length, //length of the tasks
      (i) => TaskModel(
        //task model
        id: maps[i]['id'],
        taskName: maps[i]['name'],
        taskCompleted: maps[i]['completed'] == 1,
        userId: maps[i]['userId'],
      ),
    );
  }

  static Future<int> updateTask(TaskModel task) async {
    //update the task
    return await _database!.update(
      //update the task
      tableName,
      _taskToMap(task), //task as a map
      where: 'id = ?', //where clause to filter the tasks
      whereArgs: [task.id], //where clause arguments to filter the tasks
    );
  }

  static Future<int> deleteTask(int id) async {
    //delete the task by id
    return await _database!.delete(
      //delete the task by id
      tableName,
      where: 'id = ?', //where clause to filter the tasks
      whereArgs: [id], //where clause arguments to filter the tasks
    );
  }

  static Future<List<UserModel>> getUsers() async {
    //get all the users
    final List<Map<String, dynamic>> maps = await _database!.query(usersTable);
    return maps
        .map(
          (u) => UserModel(
            //map the users
            id: u['id'],
            username: u['username'],
            email: u['email'],
            firstName: u['firstName'],
            lastName: u['lastName'],
            gender: u['gender'],
            image: u['image'],
            accessToken: u['accessToken'],
            //access token is optional
            refreshToken: u['refreshToken'], //refresh token is optional
          ),
        )
        .toList(); //return the users
  }

  static Future<UserModel?> getUserByUsername(String username) async {
    //get the user by username
    final List<Map<String, dynamic>> maps = await _database!.query(
      usersTable,
      where: 'username = ?', //where clause to filter the users
      whereArgs: [username], //where clause arguments to filter the users
    );

    if (maps.isEmpty) return null;

    final u = maps.first; //get the user
    return UserModel(
      //return the user
      id: u['id'],
      username: u['username'],
      email: u['email'],
      firstName: u['firstName'],
      lastName: u['lastName'],
      gender: u['gender'],
      image: u['image'],
      accessToken: u['accessToken'],
      refreshToken: u['refreshToken'],
    );
  }
}
