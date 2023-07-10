import 'package:flutter/services.dart';

class Helper {
  static String formatDouble(double value) {
    String stringValue = value.toStringAsFixed(2);
    return stringValue.replaceAll('.', ',');
  }

  static TextInputFormatter decimalFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+([.,]\d+)?$'));
}
