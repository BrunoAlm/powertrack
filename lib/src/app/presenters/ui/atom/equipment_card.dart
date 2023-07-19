import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/edit_equipment_dialog.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class EquipmentCard extends StatelessWidget {
  final String name;
  final int qty;
  final TimeOfDay time;
  final int power;

  const EquipmentCard({
    super.key,
    required this.name,
    required this.qty,
    required this.time,
    required this.power,
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
                      '${qty}x $name',
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
                        '${power}W',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${time.format(context)}h',
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
                        showDialog(
                          context: context,
                          builder: (context) => EditEquipmentDialog(
                            name: name,
                            power: power.toString(),
                            time: time.format(context),
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
