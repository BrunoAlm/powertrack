import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/theme_service.dart';
import 'package:uitcc/app/ui/entities/user_prefs_entity.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';

class UserPrefsController extends ChangeNotifier {
  final AppwriteAuth _appwriteAuth;
  UserPrefsController(this._appwriteAuth);
  UserPrefsEntity? userPrefs;

  Future getUserPrefs() async {
    try {
      userPrefs = await _appwriteAuth.getUserPref();
      if (userPrefs != null) {
        userPrefs = UserPrefsEntity(theme: 0);
        updateUserPref(userPrefs!);
        print('new user prefs: $userPrefs');
      }
    } catch (e) {
      print("Ocorreu um erro ao buscar as preferências do usuário: $e");
      rethrow;
    }
    notifyListeners();
  }

  Future updateUserPref(UserPrefsEntity prefs) async {
    try {
      await _appwriteAuth.updateUserPref(prefs);
      ThemeService().changeTheme(userPrefs!.theme);
    } catch (e) {
      print("Ocorreu um erro ao atualizarF as preferências do usuário: $e");
      rethrow;
    }
    notifyListeners();
  }
}
