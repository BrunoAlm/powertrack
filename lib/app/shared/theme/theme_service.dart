import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/app_theme.dart';
import 'package:uitcc/app/shared/theme/dark_theme.dart';
import 'package:uitcc/app/shared/theme/themes.dart';

class ThemeService extends ChangeNotifier {
  Themes index = Themes.dark;
  AppTheme theme = AppThemeDark();

  static final ThemeService _singleton = ThemeService._internal();

  factory ThemeService() {
    return _singleton;
  }

  ThemeService._internal();

  static AppTheme get of => ThemeService().theme;

  void changeTheme([int? value]) {
    index = Themes.values[value ?? 0];

    notifyListeners();
  }

  ThemeData returnThemeData() {
    theme = AppTheme.returnThemeApp(index);
    if (theme.isDarkTheme) {
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: theme.backgroundColor,
        primaryColor: theme.primaryColor,
        textTheme: theme.textTheme,
        colorScheme: theme.colorScheme.copyWith(
          background: theme.backgroundColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: theme.buttonStyle),
      );
    }
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: theme.backgroundColor,
      primaryColor: theme.primaryColor,
      textTheme: theme.textTheme,
      colorScheme: theme.colorScheme.copyWith(
        background: theme.backgroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: theme.buttonStyle),
    );
  }
}
