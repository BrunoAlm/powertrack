import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uitcc/src/features/login/domain/entity/user_entity.dart';
import 'package:uitcc/src/features/login/domain/entity/user_prefs_entity.dart';
import 'package:uitcc/src/features/login/presenters/states/login_state.dart';
import 'package:uitcc/src/core/data/datasources/appwrite_auth.dart';
import 'package:uitcc/src/core/services/translate/appwrite_message.dart';

class LoginController extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final logger = Logger();
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
      logger.e(e.message);
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
      await _appwrite.logout(userConnected.id);
      state.value = PendingLoginState();
    } on AppwriteException catch (e) {
      state.value = FailedLoginState(
        message: _translate.translateMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }

  Future<void> getUserData() async {
    try {
      userConnected = await _appwrite.getUser();
    } catch (e) {
      logger.e(e);
    }
  }

  Future getUserPrefs() async {
    try {
      userPrefs = await _appwrite.getUserPref();
    } catch (e) {
      logger.e(e);
      await updateUserPref(UserPrefsEntity(theme: 'light', tax: 0.0));
    }
    if (userPrefs.theme.isEmpty) {
      await updateUserPref(UserPrefsEntity(theme: 'light', tax: 0.0));
    }
    notifyListeners();
  }

  Future<void> updateUserPref(UserPrefsEntity prefs) async {
    try {
      await _appwrite.updateUserPref(prefs);
    } catch (e) {
      logger.e("Ocorreu um erro ao atualizar as preferências do usuário: $e");
      rethrow;
    }
    notifyListeners();
  }

  void updateTheme(String newTheme) async {
    var theme = userPrefs.theme;
    theme = newTheme;

    await updateUserPref(UserPrefsEntity(theme: theme, tax: userPrefs.tax));
    await getUserPrefs();
    changeThemeMode();
  }

  void updateTax(double tax) async {
    try {
      await updateUserPref(UserPrefsEntity(theme: userPrefs.theme, tax: tax));
      await getUserPrefs();
      logger.i('adicionado $tax');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  ThemeMode changeThemeMode() {
    try {
      switch (userPrefs.theme) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.light;
      }
    } catch (e) {
      return ThemeMode.light;
    }
  }
}
