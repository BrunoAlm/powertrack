import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/register/states/register_states.dart';
import 'package:uitcc/app/auth/appwrite_auth.dart';
import 'package:uitcc/app/translate/appwrite_message.dart';

class RegisterStore extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final _translate = AppwriteMessage();

  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final state = ValueNotifier<RegisterState>(PendingRegisterState());

  RegisterStore(this._appwrite);

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
        message: _translate.translateMessage(e.message!),
        code: e.code ?? 0,
      );
    }
  }
}

// enum LoginState { success, failed, pending }
