import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/features/login/presenters/states/login_state.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/features/app/ui/atoms/custom_text_form_field.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';
import 'package:uitcc/src/features/login/presenters/ui/pages/desktop_login_page.dart';
import 'package:uitcc/src/features/login/presenters/ui/pages/mobile_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginController loginStore = Modular.get();
  bool isLoggedIn = false;

  void _checkIsLoggedIn() async {
    isLoggedIn = await loginStore.isLoggedIn();
    if (isLoggedIn) {
      loginStore.state.value = SuccessLoginState();
    }
  }

  @override
  void initState() {
    _checkIsLoggedIn();

    loginStore.state.addListener(
      () {
        final state = loginStore.state.value;
        if (!isLoggedIn) {
          Modular.to.popUntil(ModalRoute.withName('/login/'));
        }
        if (state is SuccessLoginState) {
          Modular.to.pushNamed('/home/');
        }
        if (state is FailedLoginState) {
          Helper.appwriteErrorDialog(
            message: state.message,
            code: state.code,
            context: context,
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    loginStore.emailEC;
    loginStore.passwordEC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return constraints.maxWidth <= BREAK_MOBILE
              ? const MobileLoginPage()
              : const DesktopLoginPage();
        }),
      ),
    );
  }
}

const int BREAK_MOBILE = 800;
