import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/cores.dart';
import 'package:uitcc/app/ui/controllers/equipments_controller.dart';

class OverallConsumptionCard extends StatelessWidget {
  final EquipmentsController ct;
  const OverallConsumptionCard({super.key, required this.ct});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'kW/h',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  '${ct.totalPower()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            Container(
              width: 1.5,
              color: Colors.white,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pico',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  '19:00 - 21:00',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            Container(
              width: 1.5,
              color: Colors.white,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Equip.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  '${ct.totalEquipments()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
