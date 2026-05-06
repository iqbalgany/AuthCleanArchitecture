import 'package:auth_clean_architecture/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:auth_clean_architecture/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auth_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/login_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/logout_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/register_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(auth: getIt(), firestore: getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: getIt()),
  );

  getIt.registerLazySingleton(() => LoginAuthUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(
    () => RegisterAuthUseCase(authRepository: getIt()),
  );
  getIt.registerLazySingleton(() => LogoutAuthUseCase(authRepository: getIt()));

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginAuthUseCase: getIt(),
      registerAuthUseCase: getIt(),
      logoutAuthUseCase: getIt(),
    ),
  );
}
