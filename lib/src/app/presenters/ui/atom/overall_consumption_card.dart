import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';

class OverallConsumptionCard extends StatelessWidget {
  final EquipmentsController ct;
  const OverallConsumptionCard({super.key, required this.ct});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('kW/h', style: Theme.of(context).textTheme.bodyLarge!),
                Text(
                  '${ct.totalPower()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Container(
              width: 1.5,
              color: Theme.of(context).disabledColor,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pico',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
                Text(
                  'temqve',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Container(
              width: 1.5,
              color: Theme.of(context).disabledColor,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Equip.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
                Text(
                  '${ct.totalEquipments()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
