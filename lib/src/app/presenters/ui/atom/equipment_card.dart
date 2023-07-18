import 'package:flutter/material.dart';
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
    return Card(
      child: Container(
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          shadows: ThemeHelper.shadow(context),
          color: Theme.of(context).colorScheme.background,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${qty}x ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Flexible(
                  child: Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${power}W'),
                    Text('${time.format(context)}h'),
                  ],
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    shadows: ThemeHelper.shadow(context),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
