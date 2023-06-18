// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/src/app/domain/entities/user_entity.dart';
import 'package:uitcc/src/app/domain/entities/user_prefs_entity.dart';
import 'package:uitcc/src/app/presenters/ui/states/login_state.dart';
import 'package:uitcc/src/app/data/datasources/appwrite_auth.dart';
import 'package:uitcc/src/core/services/translate/appwrite_message.dart';

class LoginController extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final _translate = AppwriteMessage();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<LoginState>(PendingLoginState());
  LoginController(this._appwrite);
  late UserEntity userConnected;
  late UserPrefsEntity userPrefs;

  Future initUser() async {
    await getUserData();
    await getUserPrefs();
  }

  Future login() async {
    state.value = LoadingLoginState();
    try {
      await _appwrite.login(emailEC.text.trim(), passwordEC.text.trim());
      state.value = SuccessLoginState();
    } on AppwriteException catch (e) {
      print(e.message);
      state.value = FailedLoginState(
        message: _translate.translateMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      await _appwrite.checkIsLoggedIn();
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() async {
    state.value = LoadingLoginState();
    try {
      await _appwrite.logout();
      state.value = PendingLoginState();
    } on AppwriteException catch (e) {
      state.value = FailedLoginState(
        message: _translate.translateMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }

  Future<void> getUserData() async {
    userConnected = await _appwrite.getUser();
  }

  Future getUserPrefs() async {
    userPrefs = await _appwrite.getUserPref();
    if (userPrefs.theme.isEmpty) {
      await updateUserPref(UserPrefsEntity(theme: 'light'));
    }
    notifyListeners();
  }

  Future updateUserPref(UserPrefsEntity prefs) async {
    try {
      await _appwrite.updateUserPref(prefs);
    } catch (e) {
      print("Ocorreu um erro ao atualizar as preferências do usuário: $e");
      rethrow;
    }
    notifyListeners();
  }

  void alternateTheme() {
    var theme = userPrefs.theme;
    if (theme == 'light') {
      userPrefs.theme = 'dark';
      updateUserPref(UserPrefsEntity(theme: theme));
    } else {
      userPrefs.theme = 'light';
      updateUserPref(UserPrefsEntity(theme: theme));
    }
    changeThemeMode();
  }

  ThemeMode changeThemeMode() {
    try {
      switch (userPrefs.theme) {
        case 'light':
          return ThemeMode.dark;
        case 'dark':
          return ThemeMode.light;
        default:
          return ThemeMode.light;
      }
    } catch (e) {
      print(e);
      return ThemeMode.light;
    }
  }
}
