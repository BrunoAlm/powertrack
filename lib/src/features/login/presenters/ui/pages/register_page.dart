import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';
import 'package:uitcc/src/features/login/presenters/controllers/register_controller.dart';
import 'package:uitcc/src/features/login/presenters/states/register_state.dart';
import 'package:uitcc/src/features/app/ui/atoms/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerStore = Modular.get();

  void _registerErrorDialog(String message, int code) => showDialog(
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

  Future _registerSuccessDialog() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sucesso!'),
          content: const SizedBox(
            height: 50,
            child: Text('Usuário criado!'),
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
      () async {
        final state = registerStore.state.value;
        if (state is SuccessRegisterState) {
          await _registerSuccessDialog();
          Modular.to.popUntil(ModalRoute.withName('/'));
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
    return SafeArea(
      child: Scaffold(
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
                      const Image(
                        image: AssetImage('assets/images/tcc_logo.png'),
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
                      Container(
                        decoration: ShapeDecoration(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          shadows: ThemeHelper.shadow(context),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            registerStore.register();
                            // se der certo faz push pra /home
                            // se der erro mostra popup de usuário e/ou senha incorretos
                          },
                          child: const Text('Criar'),
                        ),
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
      ),
    );
  }
}
