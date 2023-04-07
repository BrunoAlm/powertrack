import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/login/states/login_state.dart';
import 'package:uitcc/app/register/states/register_states.dart';
import 'package:uitcc/database/appwrite_db.dart';

class RegisterStore extends ChangeNotifier {
  final AppwriteDB _appwrite;
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<RegisterState>(LoadingRegisterState());

  RegisterStore(this._appwrite);

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

  Future register() async {
    state.value = LoadingRegisterState();
    try {
      await _appwrite.register(
          name: nameEC.text.trim(),
          email: emailEC.text.trim(),
          password: passwordEC.text.trim());
      state.value = SuccessRegisterState();
    } on AppwriteException catch (e) {
      print(e.message);

      state.value = FailedRegisterState(
        message: translateMessage(e.message!),
        code: e.code!,
      );
    }
  }
}

// enum LoginState { success, failed, pending }
