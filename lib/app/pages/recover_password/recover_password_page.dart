import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uitcc/app/shared/widgets/custom_text_form_field.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final emailEC = TextEditingController();

  @override
  void dispose() {
    emailEC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Center(
            child: SizedBox(
              width: 310,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/tcc_logo.svg',
                      width: 200,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Esqueceu a senha?',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Se estiver cadastrado, enviaremos um email para recuperação!',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      maxWidth: 300,
                      hintText: 'Email',
                      controller: emailEC,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // logica de validar o usuário e senha
                        // if (senhaEC.value.text == 'admin' &&
                        //     usuarioEC.value.text == 'admin') {
                        // } else {
                        //   print(
                        //       'senha:${senhaEC.value.text} usuário:${usuarioEC.value.text} ');
                        // }
                        // Modular.to.pushNamed('/home/');

                        // se der certo faz push pra /home
                        // se der erro mostra popup de usuário e/ou senha incorretos
                      },
                      child: const Text('Recuperar'),
                    ),
                    const SizedBox(height: 55),
                    const Text("Usando energia da forma correta"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
