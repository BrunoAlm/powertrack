import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/states/login_state.dart';
import 'package:uitcc/app/ui/stores/login_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var loginStore = Modular.get<LoginStore>();

  late Future _data;

  void _logoutErrorDialog(String message, int code) => showDialog(
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

  @override
  void initState() {
    _data = loginStore.getUserData();
    loginStore.state.addListener(
      () {
        final state = loginStore.state.value;
        if (state is SuccessLoginState) {
          Modular.to.pushNamed('/home/');
        }
        if (state is FailedLoginState) {
          _logoutErrorDialog(state.message, state.code);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    loginStore.userConnected.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          loginStore.logout();
                          Modular.to.popUntil(ModalRoute.withName('/'));
                        },
                        child: const Text('Desconectar'),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Configurações'),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),
                ],
              );
            }),
      ),
    );
  }
}
