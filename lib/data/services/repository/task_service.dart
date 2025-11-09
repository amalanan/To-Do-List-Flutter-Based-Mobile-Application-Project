import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todolistgsg/imports.dart';

class TaskService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<TaskModel>> fetchTasksForUser(int userId) async {
    // get tasks for user
    final user = await SessionService.getSavedUser(); // get user from session
    if (user == null) {
      throw Exception('User not authenticated'); // if user is not authenticated
    }

    final localTasks = await getLocalTasks(userId); // get local tasks
    if (localTasks.isNotEmpty) {
      // if local tasks are available
      return localTasks; // get local tasks if available
    }

    try {
      // try to get tasks from API
      final response = await http.get(
        // get tasks from API
        Uri.parse('$baseUrl/users/$userId/todos'), // get tasks from API
        headers: {'Content-Type': 'application/json'}, // set headers
      );

      if (response.statusCode == 200) {
        // if the response is successful
        final List todosJson =
            jsonDecode(response.body)['todos'] ?? []; // get tasks from API
        final tasks =
            todosJson
                .map((json) => TaskModel.fromJson(json))
                .toList(); // convert tasks to TaskModel
        // add tasks to sqlite
        for (var task in tasks) {
          await TasksSqliteDb.insertOrIgnore(task); // add tasks to sqlite
        }

        return tasks; // get tasks from API
      } else {
        return localTasks; // get local tasks if API fails
      }
    } catch (e) {
      return localTasks; // get local tasks if API fails
    }
  }

  // add task to sqlite
  Future<TaskModel> addTask(TaskModel task) async {
    final id = await TasksSqliteDb.insertTask(task);
    task.id = id;
    return task;
  }

  // update task in sqlite
  Future<void> updateTask(TaskModel task) async {
    await TasksSqliteDb.updateTask(task);
  }

  // delete task from sqlite
  Future<void> deleteTask(int id) async {
    await TasksSqliteDb.deleteTask(id);
  }

  // get local tasks from sqlite
  Future<List<TaskModel>> getLocalTasks(int userId) async {
    final tasks = await TasksSqliteDb.getTasksForUser(userId);
    return tasks.where((t) => t.userId == userId).toList();
  }
}
