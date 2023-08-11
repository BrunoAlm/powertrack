import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/active_button.dart';
import 'package:uitcc/src/app/presenters/ui/atom/equipment_card.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/edit_equipment_bottomsheet.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/register_equipments_page.dart';

class EquipmentsNavigationPage extends StatefulWidget {
  final EquipmentsController equipmentsCt;
  const EquipmentsNavigationPage({
    Key? key,
    required this.equipmentsCt,
  }) : super(key: key);

  @override
  State<EquipmentsNavigationPage> createState() =>
      _EquipmentsNavigationPageState();
}

class _EquipmentsNavigationPageState extends State<EquipmentsNavigationPage> {
  @override
  void initState() {
    widget.equipmentsCt.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var equipments = widget.equipmentsCt.loadedEquipments;
    return Expanded(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                'Equipamentos cadastrados',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700),
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
                        equipment: equipments[index],
                        ct: widget.equipmentsCt,
                        onEditPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (context) => EditEquipmentBottomSheet(
                            equip: equipments[index],
                            ct: widget.equipmentsCt,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActiveButton(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => RegisterEquipmentsPage(
                    equipmentCt: widget.equipmentsCt,
                  ),
                ),
                text: 'Adicionar',
                icon: Icons.add_circle_outline,
                position: ActiveButtonPosition.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
