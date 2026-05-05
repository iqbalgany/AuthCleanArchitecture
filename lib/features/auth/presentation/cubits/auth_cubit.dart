import 'package:auth_clean_architecture/features/auth/domain/usecases/login_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/logout_auth_use_case.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/register_auth_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginAuthUseCase loginAuthUseCase;
  final RegisterAuthUseCase registerAuthUseCase;
  final LogoutAuthUseCase logoutAuthUseCase;
  AuthCubit({
    required this.loginAuthUseCase,
    required this.registerAuthUseCase,
    required this.logoutAuthUseCase,
  }) : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await loginAuthUseCase.call(email, password);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> register(String email, String password, String fullName) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await registerAuthUseCase.call(email, password, fullName);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await logoutAuthUseCase.call();
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }
}
