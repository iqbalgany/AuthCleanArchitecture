import 'package:auth_clean_architecture/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.fullName,
  });

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'fullName': fullName};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
    );
  }
}
