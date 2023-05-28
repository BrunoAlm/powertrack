// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/controllers/equipments_controller.dart';
import 'package:uitcc/app/ui/controllers/login_store.dart';

class SettingsNavigationPage extends StatefulWidget {
  final LoginStore loginStore;
  final EquipmentsController equipmentsStore;
  const SettingsNavigationPage({
    Key? key,
    required this.loginStore,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  State<SettingsNavigationPage> createState() => _SettingsNavigationPageState();
}

class _SettingsNavigationPageState extends State<SettingsNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            widget.loginStore.userConnected.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.loginStore.logout();
                  Modular.to.popUntil(ModalRoute.withName('/'));
                },
                child: const Text('Desconectar'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.equipmentsStore.deleteAllDocuments();
                  // setState(() {
                  //   widget.equipmentsStore.listDocuments();
                  // });
                },
                child: const Text('APAGAR equipamentos cadastrados'),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
