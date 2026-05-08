import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  final String _userKey = 'registered_users';
  final String _sessionKey = 'user_token';
  final String _userDataKey = 'current_user_data';

  String _hashPassword(String password) =>
      sha256.convert(utf8.encode(password)).toString();

  Future<void> register(String email, String password, String fullName) async {
    final prefs = await SharedPreferences.getInstance();

    String? usersJson = prefs.getString(_userKey);
    Map<String, dynamic> users = usersJson != null ? jsonDecode(usersJson) : {};

    if (users.containsKey(email)) {
      throw 'Your email address has been registered!';
    }

    users[email] = {
      'email': email,
      'password': _hashPassword(password),
      'fullName': fullName,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    await prefs.setString(_userKey, jsonEncode(users));
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? usersJson = prefs.getString(_userKey);
    if (usersJson == null) throw 'No users have registered yet!';

    Map<String, dynamic> users = jsonDecode(usersJson);

    if (!users.containsKey(email)) {
      throw 'Email not found!';
    }

    var userData = users[email];

    if (userData['password'] != _hashPassword(password)) {
      throw 'Incorrect password!';
    }

    String fakeToken = 'token_${DateTime.now().millisecondsSinceEpoch}';

    await prefs.setString(_sessionKey, fakeToken);

    await prefs.setString(_userDataKey, jsonEncode(userData));

    return userData;
  }

  Future<Map<String, dynamic>?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(_userDataKey);
    if (userDataJson != null) {
      return jsonDecode(userDataJson) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    await prefs.remove(_userDataKey);
  }
}
