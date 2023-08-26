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
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Quant.',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
      child: ButtonTheme(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        child: DropdownButton<int>(
          value: widget.equipment.qty,
          onChanged: (value) {
            widget.equipment.qty = value!;
            setState(() {});
          },
          underline: const SizedBox(),
          menuMaxHeight: 250,
          borderRadius: BorderRadius.circular(12),
          padding: EdgeInsets.zero,
          items: List.generate(
            15,
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
      ),
    );
  }
}
