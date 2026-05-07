import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase({required this.authRepository});

  Future<UserEntity?> call() {
    return authRepository.getCurrentUser();
  }
}
