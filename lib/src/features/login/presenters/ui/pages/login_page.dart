import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uitcc/src/features/login/presenters/states/login_state.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/features/app/ui/atoms/custom_text_form_field.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 310),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TCC\nENG. DA COMPUTAÇÃO',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).width * .07),
                  SvgPicture.asset(
                    'assets/images/svg/tcc_logo.svg',
                    width: 200,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).width * .07),
                  Text(
                    'USO DE ENERGIA',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).width * .07),
                  CustomTextFormField(
                    maxWidth: 300,
                    hintText: 'Email',
                    controller: loginStore.emailEC,
                    inputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.mail),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    maxWidth: 300,
                    hintText: 'Senha',
                    inputAction: TextInputAction.go,
                    onSubmit: (value) => loginStore.login(),
                    controller: loginStore.passwordEC,
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Modular.to.pushNamed('/register/'),
                        child: Text(
                          'Criar uma conta',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Modular.to.pushNamed('/recover-password/');
                          Helper.notImplementedSnackbar(context);
                        },
                        child: Text(
                          'Esqueci a senha',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).width * .07),
                  Container(
                    decoration: ShapeDecoration(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                      shadows: ThemeHelper.shadow(context),
                    ),
                    child: AnimatedBuilder(
                        animation: loginStore.state,
                        builder: (context, child) {
                          return ElevatedButton(
                            onPressed: () => loginStore.login(),
                            child: loginStore.state.value is LoadingLoginState
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Entrar',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                          );
                        }),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).width * .07),
                  Text(
                    "Usando energia da forma correta",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
