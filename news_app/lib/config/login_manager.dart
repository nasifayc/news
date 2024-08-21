import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static const String _userKey = 'user';

  static void saveUser(String email, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Map<String, String> userData = {
        'email': email,
        'password': password,
      };
      // Store the user data as a JSON string
      await prefs.setString(_userKey, jsonEncode(userData));
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  static Future<Map<String, String>?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final Map<String, dynamic> userData = jsonDecode(userJson);
        return userData.map((key, value) => MapEntry(key, value.toString()));
      }
    } catch (e) {
      print('Error retrieving user: $e');
    }
    return null;
  }

  static Future<void> deleteUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
