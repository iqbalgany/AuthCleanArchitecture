import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase({required this.authRepository});

  Future<UserEntity?> call() async {
    return await authRepository.getCurrentUser();
  }
}
