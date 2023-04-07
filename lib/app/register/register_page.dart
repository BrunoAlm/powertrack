import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uitcc/app/register/states/register_states.dart';
import 'package:uitcc/app/register/store/register_store.dart';
import 'package:uitcc/app/shared/widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerStore = Modular.get<RegisterStore>();

  void _registerErrorDialog(String message, int code) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: SizedBox(
            height: 50,
            child: Column(
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

  @override
  void initState() {
    registerStore.state.addListener(
      () {
        final state = registerStore.state.value;
        if (state is SuccessRegisterState) {
          Modular.to.pushNamed('/home/');
        }
        if (state is FailedRegisterState) {
          _registerErrorDialog(state.message, state.code);
        }
      },
    );
    super.initState();
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
                      'Criar uma conta',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    CustomTextFormField(
                      maxWidth: 300,
                      hintText: 'Nome',
                      controller: registerStore.nameEC,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      maxWidth: 300,
                      hintText: 'Email',
                      controller: registerStore.emailEC,
                      prefixIcon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      maxWidth: 300,
                      hintText: 'Senha',
                      controller: registerStore.passwordEC,
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        registerStore.register();
                        // se der certo faz push pra /home
                        // se der erro mostra popup de usuário e/ou senha incorretos
                      },
                      child: const Text('Criar'),
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
