import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uitcc/app/ui/states/login_state.dart';
import 'package:uitcc/app/ui/stores/login_store.dart';
import 'package:uitcc/app/shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore loginStore = Modular.get();
  bool isLoggedIn = false;
  void _loginErrorDialog(String message, int code) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Mensagem: $message'), Text('Código: $code')],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Modular.to.pop(),
              child: const Text('Voltar'),
            ),
          ],
        ),
      );

  void _checkIsLoggedIn() async {
    isLoggedIn = await loginStore.isLoggedIn();
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
          _loginErrorDialog(state.message, state.code);
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
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 310),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/svg/tcc_logo.svg',
                  width: 200,
                ),
                const SizedBox(height: 40),
                Text(
                  'USO DE ENERGIA',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                CustomTextFormField(
                  maxWidth: 300,
                  hintText: 'Email',
                  controller: loginStore.emailEC,
                  prefixIcon: const Icon(Icons.mail),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  maxWidth: 300,
                  hintText: 'Senha',
                  controller: loginStore.passwordEC,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Modular.to.pushNamed('/register/'),
                      child: const Text('Criar uma conta'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () =>
                          Modular.to.pushNamed('/recover-password/'),
                      child: const Text('Esqueci a senha'),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                AnimatedBuilder(
                    animation: loginStore.state,
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: () {
                          loginStore.login();
                        },
                        child: loginStore.state.value is LoadingLoginState
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Entrar'),
                      );
                    }),
                const SizedBox(height: 55),
                const Text("Usando energia da forma correta"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
