import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';

class QtyDropdown extends StatefulWidget {
  final EquipmentModel equipment;
  const QtyDropdown({super.key, required this.equipment});

  @override
  State<QtyDropdown> createState() => _QtyDropdownState();
}

class _QtyDropdownState extends State<QtyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          side: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: DropdownButton<int>(
        value: widget.equipment.qty,
        onChanged: (value) {
          widget.equipment.qty = value!;
          setState(() {});
        },
        underline: const SizedBox(),
        menuMaxHeight: 260,
        borderRadius: BorderRadius.circular(12),
        padding: EdgeInsets.zero,
        items: List.generate(
          10,
          (index) {
            return DropdownMenuItem(
              value: index + 1,
              child: Text(
                (index + 1).toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          },
        ),
      ),
    );
  }
}
