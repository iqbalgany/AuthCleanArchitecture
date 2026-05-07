import 'dart:convert';

import 'package:auth_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';

class AuthLocalDatasource {
  final String _boxName = 'userBox';

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<UserModel> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      var box = await Hive.openBox<UserModel>(_boxName);

      if (box.containsKey(email)) {
        throw 'Email already registered!';
      }

      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        fullName: fullName,
        password: _hashPassword(password),
      );

      await box.put(email, newUser);

      // await box.put('currentUser', newUser);

      return newUser;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      var box = await Hive.openBox<UserModel>(_boxName);

      await box.delete('currentUser');

      final user = box.get(email);

      if (user == null) {
        throw 'Your email address is not registered! Please register first.';
      }

      if (user.password != _hashPassword(password)) {
        throw 'Invalid email or password. Please try again.';
      }

      await box.put('currentUser', user);
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> logout() async {
    try {
      var box = await Hive.openBox<UserModel>(_boxName);
      await box.delete('currentUser');
      await box.flush();
    } catch (e) {
      throw 'Failed to log out';
    }
  }

  Future<UserModel?> getCurrentUser() async {
    var box = await Hive.openBox<UserModel>(_boxName);
    final user = box.get('currentUser');
    return user;
  }
}
