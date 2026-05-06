import 'package:auth_clean_architecture/core/models/either.dart';
import 'package:auth_clean_architecture/core/models/failure.dart';
import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

class LoginAuthUseCase {
  final AuthRepository authRepository;

  LoginAuthUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    return await authRepository.login(email, password);
  }
}
