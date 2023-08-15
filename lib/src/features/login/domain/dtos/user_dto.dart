import 'package:uitcc/src/features/login/domain/entity/user_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    required super.name,
    required super.email,
    required super.registrationDate,
    required super.id,
  });

  static fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['\$id'],
      email: json['email'] as String,
      name: json['name'],
      registrationDate: json['registration'],
    );
  }
}
