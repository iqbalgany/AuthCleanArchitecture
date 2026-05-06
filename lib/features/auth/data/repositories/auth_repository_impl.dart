import 'package:auth_clean_architecture/core/models/either.dart';
import 'package:auth_clean_architecture/core/models/failure.dart';
import 'package:auth_clean_architecture/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:auth_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await authRemoteDatasource.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Login failed'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDatasource.logout();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Failed to log out'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final user = await authRemoteDatasource.register(
        email,
        password,
        fullName,
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
