import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../imports.dart';

class ApiService {
  //api service
  static const String base = 'https://dummyjson.com';

  static Future<List<TaskModel>> fetchTasks() async {
    //fetch tasks
    final response = await http.get(Uri.parse('$base/todos')); //get the tasks
    if (response.statusCode == 200) {
      // if the response is successful
      List data = jsonDecode(response.body)['todos']; //get the data
      return data.map((e) => TaskModel.fromJson(e)).toList(); //return the tasks
    } else {
      throw Exception(
        'Failed to fetch tasks',
      ); //if the response is not successful
    }
  }

  static Future<List<UserModel>> fetchUsers() async {
    //fetch users
    final response = await http.get(Uri.parse('$base/users')); //get the users
    if (response.statusCode == 200) {
      //if the response is successful
      List data = jsonDecode(response.body)['users']; // get the data
      return data.map((e) => UserModel.fromJson(e)).toList(); //return the users
    } else {
      throw Exception(
        'Failed to fetch users',
      ); //if the response is not successful
    }
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final users = await fetchUsers();
    try {
      return users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
