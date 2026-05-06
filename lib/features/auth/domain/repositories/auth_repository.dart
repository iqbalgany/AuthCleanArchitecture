import 'package:auth_clean_architecture/core/models/either.dart';
import 'package:auth_clean_architecture/core/models/failure.dart';
import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(
    String email,
    String password,
    String fullName,
  );
  Future<Either<Failure, void>> logout();
}
