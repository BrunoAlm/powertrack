import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uitcc/app/shared/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioEC = TextEditingController();
  final senhaEC = TextEditingController();

  @override
  void dispose() {
    usuarioEC;
    senhaEC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 310,
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
                  hintText: 'Usuário',
                  controller: usuarioEC,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  maxWidth: 300,
                  hintText: 'Senha',
                  controller: senhaEC,
                  prefixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Modular.to.pushNamed('/register'),
                      child: const Text('Criar uma conta'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Modular.to.pushNamed('/register'),
                      child: const Text('Esqueci a senha'),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    // logica de validar o usuário e senha
                    // if (senhaEC.value.text == 'admin' &&
                    //     usuarioEC.value.text == 'admin') {
                    // } else {
                    //   print(
                    //       'senha:${senhaEC.value.text} usuário:${usuarioEC.value.text} ');
                    // }
                    Modular.to.pushNamed('/home/');

                    // se der certo faz push pra /home
                    // se der erro mostra popup de usuário e/ou senha incorretos
                  },
                  child: const Text('Entrar'),
                ),
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
