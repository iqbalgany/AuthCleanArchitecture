import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

class LoginAuthUseCase {
  final AuthRepository authRepository;

  LoginAuthUseCase({required this.authRepository});

  Future<UserEntity> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
