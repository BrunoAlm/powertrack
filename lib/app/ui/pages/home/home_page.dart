import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';
import 'package:uitcc/app/ui/stores/login_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LoginStore _loginStore = Modular.get();
  final EquipmentsStore _equipmentsStore = Modular.get();
  late Future _data;

  @override
  void initState() {
    _data = _equipmentsStore.listDocuments();
    _equipmentsStore.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Consumo de energia",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _loginStore.getUserData();
            Modular.to.pushNamed('profile/');
          },
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          icon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text('Nome do equipamento'),
                    SizedBox(width: 20),
                    Text('Quantidade'),
                    SizedBox(width: 20),
                    Text('Potência'),
                  ],
                ),
                const Divider(),
                FutureBuilder(
                    future: _data,
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          _equipmentsStore.equipments.length,
                          (index) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 205,
                                child: Text(
                                  _equipmentsStore.equipments[index].name,
                                ),
                              ),
                              SizedBox(
                                width: 65,
                                child: Text(
                                  _equipmentsStore.equipments[index].qty
                                      .toString(),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _equipmentsStore.equipments[index].power.text,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                const Divider(),
                const SizedBox(height: 50),
                Text(
                    'Total de equipamentos: ${_equipmentsStore.totalEquipments()}'),
                Text('Total de consumo: ${_equipmentsStore.totalPower()}'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Modular.to.pushNamed('cadastrar-dados'),
                  child: const Text('Cadastrar Dados'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _equipmentsStore.deleteAllDocuments();
                    setState(() {
                      _equipmentsStore.listDocuments();
                    });
                  },
                  child: const Text('Apagar tudo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
