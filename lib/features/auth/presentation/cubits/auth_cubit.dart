// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:auth_clean_architecture/features/auth/domain/usecases/get_current_user_use_case.dart';
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
  final GetCurrentUserUseCase getCurrentUserUseCase;
  AuthCubit({
    required this.loginAuthUseCase,
    required this.registerAuthUseCase,
    required this.logoutAuthUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitial());

  void checkAuthStatus() async {
    try {
      final user = await getCurrentUserUseCase.call();
      log("CHECK STATUS: ${user?.email ?? 'TIDAK ADA USER'}"); // Debug print
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await loginAuthUseCase.call(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String email, String password, String fullName) async {
    log("Mencoba mendaftar dengan email: $email");
    emit(AuthLoading());

    try {
      await registerAuthUseCase.call(email, password, fullName);
      emit(AuthRegisterSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await logoutAuthUseCase.call();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void resetState() {
    emit(AuthInitial());
  }
}
