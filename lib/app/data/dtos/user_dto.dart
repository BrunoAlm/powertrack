import 'package:uitcc/app/ui/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    required super.name,
    required super.email,
    required super.registrationDate,
  });

  static fromJson(Map<String, dynamic> json) {
    return UserEntity(
      email: json['email'] as String,
      name: json['name'],
      registrationDate: json['registration'],
    );
  }
}
