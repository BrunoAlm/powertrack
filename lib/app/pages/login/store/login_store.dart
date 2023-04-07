import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/login/states/login_state.dart';
import 'package:uitcc/app/auth/appwrite_auth.dart';

class LoginStore extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<LoginState>(PendingLoginState());

  LoginStore(this._appwrite);

  String _translateLoginMessage(String message) {
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
      case 'O computador remoto recusou a conexão de rede.':
        return 'Sem conexão com o servidor!';
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
      state.value = FailedLoginState(
        message: _translateLoginMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }

  void logout() {}
}
