import 'dart:developer';

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
    log("DEBUG: Fungsi login di Cubit terpanggil!");
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await loginAuthUseCase.call(email, password);

    result.fold(
      (failure) {
        log("DEBUG: Hasil FOLD adalah FAILURE: ${failure.errorMessage}");
        emit(
          state.copyWith(
            message: failure.errorMessage,
            status: AuthStatus.failure,
          ),
        );
      },
      (_) {
        log("DEBUG: login Berhasil, memancarkan status authenticated");
        emit(state.copyWith(status: AuthStatus.authenticated));
      },
    );
  }

  Future<void> register(String email, String password, String fullName) async {
    log("DEBUG: Fungsi register di Cubit terpanggil!");
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await registerAuthUseCase.call(email, password, fullName);

    result.fold(
      (failure) {
        log("DEBUG: Hasil FOLD adalah FAILURE: ${failure.errorMessage}");
        emit(
          state.copyWith(
            message: failure.errorMessage,
            status: AuthStatus.failure,
          ),
        );
      },
      (_) {
        log("DEBUG: Registrasi Berhasil, memancarkan status authenticated");
        emit(state.copyWith(status: AuthStatus.authenticated));
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await logoutAuthUseCase.call();
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }
}
