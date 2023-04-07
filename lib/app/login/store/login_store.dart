import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/login/states/login_state.dart';
import 'package:uitcc/database/appwrite_db.dart';

class LoginStore extends ChangeNotifier {
  final AppwriteDB _appwrite;
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<LoginState>(LoadingLoginState());

  LoginStore(this._appwrite);

  String translateMessage(String message) {
    String messageTranslated = message.toString();
    switch (messageTranslated) {
      case 'Invalid credentials. Please check the email and password.':
        return 'Usuário ou senha inválidos!';
      case 'Param "email" is not optional.':
        return 'Preencha o email.';
      case 'Param "password" is not optional.':
        return 'Preencha a senha.';
      case 'Invalid password: Password must be at least 8 characters':
        return 'Senha inválida: Precisa de pelo menos 8 caracteres';
      case 'Invalid email: Value must be a valid email address':
        return 'Insira um email válido';
      default:
    }
    return messageTranslated;
  }

  Future login() async {
    state.value = LoadingLoginState();
    try {
      await _appwrite.login(emailEC.text.trim(), passwordEC.text.trim());
      state.value = SuccessLoginState();
    } on AppwriteException catch (e) {
      print(e.message);

      state.value = FailedLoginState(
        message: translateMessage(e.message!),
        code: e.code!,
      );
    }
  }

  void logout() {}
}

// enum LoginState { success, failed, pending }
