// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String message;
  const AuthState({this.status = AuthStatus.initial, this.message = ''});

  @override
  List<Object> get props => [status, message];

  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
