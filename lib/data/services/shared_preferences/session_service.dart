//shared_preferences

import 'dart:convert';
import 'package:todolistgsg/imports.dart';

class SessionService {
  //session service
  static const _userKey = 'user_data';

  static Future<void> saveUser(UserModel user) async {
    //save the user
    final prefs =
        await SharedPreferences.getInstance(); //get the shared preferences
    await prefs.setString(_userKey, jsonEncode(user.toJson())); //save the user
  }

  static Future<UserModel?> getSavedUser() async {
    //get the user
    final prefs =
        await SharedPreferences.getInstance(); //get the shared preferences
    final raw = prefs.getString(_userKey); //get the user
    if (raw == null) return null; //if the user is null
    return UserModel.fromJson(jsonDecode(raw)); //return the user
  }

  static Future<void> clear() async {
    //clear the user
    final prefs =
        await SharedPreferences.getInstance(); //get the shared preferences
    await prefs.remove(_userKey); //remove the user
  }
}
