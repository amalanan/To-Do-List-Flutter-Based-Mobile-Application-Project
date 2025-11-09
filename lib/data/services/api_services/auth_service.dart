import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../imports.dart';

class AuthService {
  //auth service
  static const String base = 'https://dummyjson.com';

  static Future<UserModel?> loginWithUserName({
    //login with username
    required String userName,
    required String password,
  }) async {
    final response = await http.post(
      //post the login request
      Uri.parse('$base/auth/login'), //set the url
      headers: {'Content-Type': 'application/json'}, //set the headers
      body: jsonEncode({
        //encode the login request
        'username': userName,
        'password': password,
        'expiresInMins': 30, //set the expiration time
      }),
    );

    if (response.statusCode == 200) {
      //if the response is successful
      final data = jsonDecode(response.body); //get the data
      return UserModel.fromJson(data); //return the user
    } else {
      throw Exception(
        'Invalid credentials',
      ); //if the response is not successful
    }
  }
}
