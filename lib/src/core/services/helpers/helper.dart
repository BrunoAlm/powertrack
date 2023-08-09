import 'package:flutter/material.dart';

class Helper {
  static String formatDouble(double value) {
    String stringValue = value.toStringAsFixed(2);
    return stringValue.replaceAll('.', ',');
  }

  /// Gera um ID com base no horário
  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
}

class ThemeHelper {
  static List<BoxShadow> lightShadow = [
    const BoxShadow(
      color: Color.fromARGB(12, 255, 255, 255),
      blurRadius: 6,
      offset: Offset(0, 1),
      spreadRadius: 0,
    )
  ];
  static List<BoxShadow> darkShadow = [
    const BoxShadow(
      color: Color.fromARGB(24, 0, 0, 0),
      blurRadius: 6,
      offset: Offset(0, 1),
      spreadRadius: 0,
    )
  ];

  static List<BoxShadow> shadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeHelper.lightShadow
          : ThemeHelper.darkShadow;
}
