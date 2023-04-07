import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/register/states/register_states.dart';
import 'package:uitcc/app/auth/appwrite_auth.dart';

class RegisterStore extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var state = ValueNotifier<RegisterState>(PendingRegisterState());

  RegisterStore(this._appwrite);

  String _translateRegisterMessage(String message) {
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
      case 'A user with the same email already exists in your project.':
        return 'Email já registrado!';
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
        password: passwordEC.text.trim(),
      );
      state.value = SuccessRegisterState();
    } on AppwriteException catch (e) {
      state.value = FailedRegisterState(
        message: _translateRegisterMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }
}

// enum LoginState { success, failed, pending }
