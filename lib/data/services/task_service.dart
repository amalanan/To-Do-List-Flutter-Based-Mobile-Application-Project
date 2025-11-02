import '../../database/database_helper.dart';
import '../models/task_model.dart';
import 'api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class TaskService {
  final dbHelper = DatabaseHelper();

  Future<bool> _hasInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<List<TaskModel>> getTasks() async {
    bool online = await _hasInternet();
    List<TaskModel> tasks = [];

    if (online) {
      try {
        final data = await ApiService.get('todos');
        final List<dynamic> todosJson = data['todos'];
        tasks = todosJson.map((json) => TaskModel.fromJson(json)).toList();

        // خزّن المهام في SQLite
        for (var task in tasks) {
          await dbHelper.insertTask(task);
        }
      } catch (e) {
        print('API fetch failed: $e');
        tasks = await dbHelper.getTasks();
      }
    } else {
      tasks = await dbHelper.getTasks();
    }

    return tasks;
  }

  Future<TaskModel> addTask(TaskModel task) async {
    int id = await dbHelper.insertTask(task);
    task.id = id;
    return task;
  }

  Future<void> updateTask(TaskModel task) async {
    await dbHelper.updateTask(task);
  }

  Future<void> deleteTask(int id) async {
    await dbHelper.deleteTask(id);
  }
}
