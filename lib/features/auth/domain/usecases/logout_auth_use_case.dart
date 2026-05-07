import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

class LogoutAuthUseCase {
  final AuthRepository authRepository;

  LogoutAuthUseCase({required this.authRepository});

  Future<void> call() async {
    return await authRepository.logout();
  }
}
