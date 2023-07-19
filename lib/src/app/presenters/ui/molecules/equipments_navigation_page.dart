import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/equipment_card.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/register_equipments_page.dart';

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
        body: Center(
          child: Column(
            children: [
              Text(
                'Equipamentos cadastrados',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 100),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    direction: Axis.horizontal,
                    children: List.generate(
                      equipments.length,
                      (index) => EquipmentCard(
                        name: equipments[index].name,
                        qty: equipments[index].qty,
                        time: equipments[index].time!,
                        power: int.parse(equipments[index].power.text),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const RegisterEquipments(),
          ),
          label: const Text('Adicionar'),
          icon: const Icon(Icons.add_circle_outline_rounded),
        ),
      ),
    );
  }
}
