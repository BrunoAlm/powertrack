import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';
import 'package:uitcc/src/features/app/ui/atoms/custom_text_form_field.dart';

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
                      Container(
                        decoration: ShapeDecoration(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          shadows: ThemeHelper.shadow(context),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Helper.notImplementedSnackbar(context,
                                'Recuperação de senha não implementada');
                            Navigator.pop(context);
                          },
                          child: const Text('Recuperar'),
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
