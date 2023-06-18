import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/ui/states/register_state.dart';
import 'package:uitcc/src/app/data/datasources/appwrite_auth.dart';
import 'package:uitcc/src/core/services/translate/appwrite_message.dart';

class RegisterController extends ChangeNotifier {
  final AppwriteAuth _appwrite;
  final _translate = AppwriteMessage();

  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final state = ValueNotifier<RegisterState>(PendingRegisterState());

  RegisterController(this._appwrite);

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
