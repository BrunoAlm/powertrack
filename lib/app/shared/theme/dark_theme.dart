import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/app_theme.dart';

class AppThemeDark implements AppTheme {
  @override
  TextTheme get textTheme => ThemeData.dark().textTheme;

  @override
  ColorScheme get colorScheme => const ColorScheme.dark()
      .copyWith(
        primary: Colors.white,
      )
      .copyWith(secondary: Colors.black);
  @override
  bool get isDarkTheme => true;
  //Background Color
  @override
  Color get backgroundColor => const Color(0xFF1e1e1e);
  @override
  Color get backgroundIcon => Colors.white;
  @override
  Color get backgroundText => const Color(0xFF9f9f9f);
  //Primary Color
  @override
  Color get primaryText => Colors.white;
  @override
  Color get primaryColor => const Color(0xFF2d2d2d);
  //Select Color
  @override
  Color get selectColor => const Color(0xFF0085fe);
  @override
  Color get selectText => const Color(0xFF9f9f9f);

  @override
  BorderRadiusGeometry get borderRadius => BorderRadius.circular(20);

  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 25,
        ),
      );
}
