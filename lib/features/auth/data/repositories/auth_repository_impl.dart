import 'package:auth_clean_architecture/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource authLocalDatasource;
  AuthRepositoryImpl({required this.authLocalDatasource});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final user = await authLocalDatasource.login(email, password);
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authLocalDatasource.logout();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserEntity> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final user = await authLocalDatasource.register(
        email,
        password,
        fullName,
      );
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await authLocalDatasource.getCurrentUser();

      return user;
    } catch (e) {
      throw e.toString();
    }
  }
}
