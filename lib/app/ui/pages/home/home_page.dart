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

  @override
  void initState() {
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
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _equipmentsStore.equipments.length,
                  (index) => Row(
                    children: [
                      Text(
                        _equipmentsStore.equipments[index].name,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _equipmentsStore.equipments[index].power.text,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _equipmentsStore.deleteAllDocuments(),
                child: const Text('Apagar tudo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
