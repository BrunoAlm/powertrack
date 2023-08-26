import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';
import 'package:uitcc/src/features/app/ui/atoms/custom_text_form_field.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/features/login/presenters/states/login_state.dart';

class DesktopLoginPage extends StatefulWidget {
  const DesktopLoginPage({super.key});

  @override
  State<DesktopLoginPage> createState() => _DesktopLoginPageState();
}

class _DesktopLoginPageState extends State<DesktopLoginPage> {
  final LoginController loginStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.inversePrimary,
            Theme.of(context).colorScheme.inversePrimary,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/tcc_logo.png'),
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).width * .03),
                  Text(
                    'POWERTRACK',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          shadows: ThemeHelper.shadow(context),
                        ),
                  ),
                ],
              ),
            ),

            // SizedBox(height: MediaQuery.sizeOf(context).width * .07),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Entrar',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w900,
                                shadows: ThemeHelper.shadow(context),
                              ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * .04),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Modular.to.pushNamed('/register/'),
                          child: Text(
                            'Criar uma conta',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Modular.to.pushNamed('/recover-password/');
                          },
                          child: Text(
                            'Esqueci a senha',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * .04),
                    Container(
                      decoration: ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
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
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                            );
                          }),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * .04),
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
          ],
        ),
      ),
    );
  }
}
