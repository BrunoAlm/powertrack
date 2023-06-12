// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/theme_service.dart';
import 'package:uitcc/app/ui/entities/user_prefs_entity.dart';

import 'package:uitcc/services/database/appwrite_db.dart';

class UserPrefsController extends ChangeNotifier {
  final AppwriteDB _appwriteDb;
  UserPrefsController(this._appwriteDb);
  UserPrefsEntity userPrefs = UserPrefsEntity();

  void getUserPrefs() async {
    print('Pegou');
    try {
      userPrefs = await _appwriteDb.getUserPrefs(userPrefs).then((value) {
        return UserPrefsEntity(id: value.id, theme: value.theme);
      });
      print('Tema alterado para: ${userPrefs.theme}');
    } catch (e) {
      print(e);
    }
    ThemeService().changeTheme(userPrefs.theme);
  }

  Future<void> updateUserPrefs({
    required UserPrefsEntity prefs,
  }) async {
    if (prefs.id != null) {
      try {
        await _appwriteDb.updateDocument(
            document: prefs.id!,
            data: UserPrefsEntity(
              theme: prefs.theme,
              id: prefs.id,
            ).toMap());
      } on AppwriteException catch (e) {
        // Print the error message from Appwrite
        print(e.message);
      }
    } else if (prefs.id == null) {
      await _appwriteDb.createUserPrefs(prefs.toMap());
    }

    // Refresh the list of documents
    getUserPrefs();
  }
}
