import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/ui/entities/user_entity.dart';
import 'package:uitcc/app/ui/states/login_state.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';
import 'package:uitcc/services/translate/appwrite_message.dart';

class LoginStore extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final _translate = AppwriteMessage();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<LoginState>(PendingLoginState());
  LoginStore(this._appwrite);
  late UserEntity userConnected;

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
    // TODO: PRECISA RECONECTAR CASO A INSTANCIA ESTEJA ABERTA

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
}
