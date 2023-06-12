// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserPrefsEntity {
  String? id;
  int? theme;

  UserPrefsEntity({
    this.id,
    this.theme = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
    };
  }

  factory UserPrefsEntity.fromMap(Map<String, dynamic> map) {
    return UserPrefsEntity(
      theme: map['theme'] as int,
      id: map['\$id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPrefsEntity.fromJson(String source) =>
      UserPrefsEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
