// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);
  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
