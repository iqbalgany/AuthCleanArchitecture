// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String id;

  final String email;

  final String fullName;

  final String password;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.password,
  });

  UserEntity toEntity() {
    return UserEntity(id: id, email: email, fullName: fullName);
  }
}
