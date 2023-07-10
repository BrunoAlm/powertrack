// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserPrefsEntity {
  String theme;
  double tax;

  UserPrefsEntity({
    required this.theme,
    required this.tax,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
      'tax': tax,
    };
  }

  factory UserPrefsEntity.fromMap(Map<String, dynamic> map) {
    return UserPrefsEntity(
      theme: map['theme'] ?? 'light',
      tax: map['tax'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPrefsEntity.fromJson(String source) =>
      UserPrefsEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
