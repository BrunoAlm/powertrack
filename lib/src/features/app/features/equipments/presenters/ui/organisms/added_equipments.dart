import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/equipment_card.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/bottomsheet/add_equipment_bottomsheet.dart';

class AddedEquipments extends StatefulWidget {
  final EquipmentsController equipmentsCt;

  const AddedEquipments({
    Key? key,
    required this.equipmentsCt,
  }) : super(key: key);

  @override
  AddedEquipmentsState createState() => AddedEquipmentsState();
}

class AddedEquipmentsState extends State<AddedEquipments> {
  @override
  void initState() {
    super.initState();
    widget.equipmentsCt.searchState.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var equipments = widget.equipmentsCt.equipmentsToBeAdded;
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 100),
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
                enableDrag: false,
                showDragHandle: false,
                useSafeArea: true,
                builder: (context) => AddEquipmentBottomSheet(
                  equip: equipments[index],
                  ct: widget.equipmentsCt,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
