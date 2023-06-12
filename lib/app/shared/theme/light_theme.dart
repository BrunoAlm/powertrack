import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/app_theme.dart';

class AppThemeLight implements AppTheme {
  @override
  TextTheme get textTheme => ThemeData.dark().textTheme;

  @override
  ColorScheme get colorScheme => const ColorScheme.dark()
      .copyWith(
        primary: Colors.white,
      )
      .copyWith(secondary: Colors.black);
  @override
  bool get isDarkTheme => false;
  //Select Color
  @override
  Color get selectColor => Colors.grey.shade300;
  @override
  Color get selectText => Colors.white;
  //Primary Color
  @override
  Color get primaryColor => const Color(0xFF0085fe);
  @override
  Color get primaryText => Colors.white;
  //Backgroud Color
  @override
  Color get backgroundColor => Colors.white;
  @override
  Color get backgroundText => const Color(0xFF1e1e1e);
  @override
  Color get backgroundIcon => const Color(0xFF1e1e1e);

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
