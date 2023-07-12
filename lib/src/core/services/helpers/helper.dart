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
    BoxShadow(
      color: const Color(0xfffefefe).withOpacity(.2),
      blurRadius: 12.0, // soften the shadow
      spreadRadius: 0.0, //extend the shadow
      offset: const Offset(
        0,
        -4,
      ),
    )
  ];
  static List<BoxShadow> darkShadow = [
    BoxShadow(
      color: const Color(0xFF0e0f12).withOpacity(.2),
      blurRadius: 12.0, // soften the shadow
      spreadRadius: 0.0, //extend the shadow
      offset: const Offset(
        0,
        -4,
      ),
    )
  ];

  static List<BoxShadow> shadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeHelper.lightShadow
          : ThemeHelper.darkShadow;
}
