// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/pages/register_equipments_page.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';

class EquipmentsNavigationPage extends StatefulWidget {
  final EquipmentsStore equipmentsStore;
  const EquipmentsNavigationPage({
    Key? key,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  State<EquipmentsNavigationPage> createState() =>
      _EquipmentsNavigationPageState();
}

class _EquipmentsNavigationPageState extends State<EquipmentsNavigationPage> {
  @override
  void initState() {
    // widget.equipmentsStore.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var equipments = widget.equipmentsStore.equipments;
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  equipments.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 205,
                        child: Text(
                          equipments[index].name,
                        ),
                      ),
                      SizedBox(
                        width: 65,
                        child: Text(
                          equipments[index].qty.toString(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        equipments[index].power.text,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 50),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return Material(
                      child: Column(
                        children: [
                          RegisterEquipments(
                            equipmentsStore: widget.equipmentsStore,
                            widgetHeight: 780,
                          ),
                          BackButton(
                            onPressed: () {
                              Modular.to.pop();
                              widget.equipmentsStore.createDocument(equipments);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                child: const Text('Adicionar Equipamentos'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
