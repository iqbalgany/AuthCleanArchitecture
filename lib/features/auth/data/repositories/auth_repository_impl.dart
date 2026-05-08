import 'package:auth_clean_architecture/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource authLocalDatasource;
  AuthRepositoryImpl({required this.authLocalDatasource});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userData = await authLocalDatasource.login(email, password);
      return UserEntity(
        id: userData['id'],
        email: userData['email'],
        fullName: userData['fullName'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(String email, String password, String fullName) async {
    try {
      await authLocalDatasource.register(email, password, fullName);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authLocalDatasource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userData = await authLocalDatasource.getSavedUser();
    if (userData != null) {
      return UserEntity(
        id: userData['id'],
        email: userData['email'],
        fullName: userData['fullName'],
      );
    }
    return null;
  }
}
