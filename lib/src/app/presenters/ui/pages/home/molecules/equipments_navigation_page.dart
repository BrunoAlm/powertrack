import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/equipment_card.dart';
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
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Equipamentos cadastrados',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 100),
                itemCount: equipments.length,
                itemBuilder: (context, index) {
                  return EquipmentCard(
                    name: equipments[index].name,
                    qty: equipments[index].qty,
                    time:
                        '${equipments[index].time!.hour}.${equipments[index].time!.minute}',
                    power: int.parse(equipments[index].power.text),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const RegisterEquipments(),
                ),
            label: const Text('Alterar'),
            icon: const Icon(Icons.edit_rounded)),
      ),
    );
  }
}
