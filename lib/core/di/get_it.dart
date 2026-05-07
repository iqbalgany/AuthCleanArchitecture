import 'package:auth_clean_architecture/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:auth_clean_architecture/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/login_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/logout_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/register_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasource());

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authLocalDatasource: getIt()),
  );

  getIt.registerLazySingleton(() => LoginAuthUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(
    () => RegisterAuthUseCase(authRepository: getIt()),
  );
  getIt.registerLazySingleton(() => LogoutAuthUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(
    () => GetCurrentUserUseCase(authRepository: getIt()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginAuthUseCase: getIt(),
      registerAuthUseCase: getIt(),
      logoutAuthUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
    ),
  );
}
