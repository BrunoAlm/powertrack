import 'package:flutter/material.dart';
import 'package:uitcc/src/app/domain/entities/equipment_model.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/edit_equipment_bottomsheet.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class EquipmentCard extends StatelessWidget {
  final EquipmentModel equipment;
  final EquipmentsController ct;
  // final String name;
  // final int qty;
  // final TimeOfDay time;
  // final int power;

  const EquipmentCard({
    super.key,
    required this.equipment,
    required this.ct,
    // required this.name,
    // required this.qty,
    // required this.time,
    // required this.power,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 140,
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        shadows: ThemeHelper.shadow(context),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      '${equipment.qty}x ${equipment.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${equipment.power.text}W',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${equipment.time!.format(context)}h',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      shadows: ThemeHelper.shadow(context),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (context) => EditEquipmentBottomSheet(
                            equipmentModel: equipment,
                            ct: ct,
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      iconSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
