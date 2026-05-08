import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> register(String email, String password, String fullName);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}
