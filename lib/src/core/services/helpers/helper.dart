import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Helper {
  static String formatDouble(double value) {
    String stringValue = value.toStringAsFixed(2);
    return stringValue.replaceAll('.', ',');
  }

  static TextInputFormatter decimalFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+([.,]\d+)?$'));
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
      color: Color.fromARGB(43, 0, 0, 0),
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
