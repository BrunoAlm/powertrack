import 'package:flutter/material.dart';

class IndividualEquipmentCard extends StatelessWidget {
  final String name;
  final String data;
  final int qty;
  final IconData icon;
  const IndividualEquipmentCard({
    Key? key,
    required this.name,
    required this.data,
    required this.qty,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: SizedBox(
          height: 150,
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton.filled(
                isSelected: false,
                onPressed: () {},
                icon: Icon(
                  icon,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$qty x $name',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      data,
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
