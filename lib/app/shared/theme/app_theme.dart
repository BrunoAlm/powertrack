import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/dark_theme.dart';
import 'package:uitcc/app/shared/theme/light_theme.dart';
import 'package:uitcc/app/shared/theme/themes.dart';

abstract class AppTheme {
  final bool isDarkTheme = false;
  abstract final Color primaryColor;
  abstract final Color backgroundColor;
  abstract final Color backgroundText;
  abstract final Color selectColor;
  abstract final Color selectText;
  abstract final Color primaryText;
  abstract final Color backgroundIcon;
  abstract final BorderRadiusGeometry borderRadius;
  abstract final ButtonStyle buttonStyle;

  final textTheme = ThemeData.dark().textTheme;

  final colorScheme = const ColorScheme.dark()
      .copyWith(
        primary: Colors.white,
      )
      .copyWith(secondary: Colors.black);
  static AppTheme returnThemeApp(Themes index) {
    switch (index) {
      case Themes.light:
        return AppThemeLight();
      default:
        return AppThemeDark();
    }
  }
}
