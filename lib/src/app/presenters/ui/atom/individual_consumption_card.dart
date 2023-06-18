import 'package:flutter/material.dart';

class IndividualConsumptionCard extends StatelessWidget {
  final String equipmentName;
  final String equipmentConsumption;
  final int qty;
  const IndividualConsumptionCard(
      {super.key,
      required this.equipmentName,
      required this.equipmentConsumption,
      required this.qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton.filled(
                isSelected: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.electric_bolt_rounded,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$qty x $equipmentName',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '$equipmentConsumption kWh',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
