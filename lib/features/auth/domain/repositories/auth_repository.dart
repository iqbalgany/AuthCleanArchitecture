import 'package:auth_clean_architecture/core/models/either.dart';
import 'package:auth_clean_architecture/core/models/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> register(
    String email,
    String password,
    String fullName,
  );
  Future<Either<Failure, void>> logout();
}
