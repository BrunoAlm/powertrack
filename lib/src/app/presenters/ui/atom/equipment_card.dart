import 'package:flutter/material.dart';

class EquipmentCard extends StatelessWidget {
  final String name;
  final int qty;
  final String time;
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
        height: 150,
        width: 260,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text('Quantidade'),
                    Text(qty.toString()),
                  ],
                ),
                Column(
                  children: [
                    const Text('Tempo p/ dia'),
                    Text(time),
                  ],
                ),
                Column(
                  children: [
                    const Text('Potência'),
                    Text(power.toString()),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
