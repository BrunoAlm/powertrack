import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/login/states/login_state.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';
import 'package:uitcc/services/translate/appwrite_message.dart';

class LoginStore extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final _translate = AppwriteMessage();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<LoginState>(PendingLoginState());
  LoginStore(this._appwrite);

  Future login() async {
    state.value = LoadingLoginState();
    try {
      await _appwrite.login(emailEC.text.trim(), passwordEC.text.trim());
      state.value = SuccessLoginState();
    } on AppwriteException catch (e) {
      print(e);
      state.value = FailedLoginState(
        message: _translate.translateMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }

  Future isLoggedIn() async {
    try {
      await _appwrite.checkIsLoggedIn();
      print('ja ta');
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    state.value = LoadingLoginState();
    try {
      await _appwrite.logout();
      state.value = SuccessLoginState();
    } on AppwriteException catch (e) {
      state.value = FailedLoginState(
        message: _translate.translateMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }
}
