// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/templates/register_equipments_page.dart';

class EquipmentsNavigationPage extends StatefulWidget {
  final EquipmentsController equipmentsStore;
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
    if (widget.equipmentsStore.equipmentsToBeAdded.isEmpty) {
      widget.equipmentsStore.equipmentsToBeAdded =
          widget.equipmentsStore.loadedEquipments;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var equipments = widget.equipmentsStore.loadedEquipments;
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
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
                  builder: (context) => const RegisterEquipments(),
                ),
                child: const Text('Editar Equipamentos'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
