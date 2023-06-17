// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserPrefsEntity {
  int theme;

  UserPrefsEntity({
    required this.theme,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
    };
  }

  factory UserPrefsEntity.fromMap(Map<String, dynamic> map) {
    return UserPrefsEntity(
      theme: map['theme'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPrefsEntity.fromJson(String source) =>
      UserPrefsEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
