// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String email;

  @override
  @HiveField(2)
  final String fullName;

  @override
  @HiveField(3)
  final String password;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.password,
  }) : super(email: email, fullName: fullName, id: id, password: password);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'email': email, 'fullName': fullName};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      password: map['password'] as String,
    );
  }
}
