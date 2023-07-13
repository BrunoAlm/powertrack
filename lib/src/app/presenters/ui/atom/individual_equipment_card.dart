import 'package:flutter/material.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

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
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: ThemeHelper.shadow(context),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: SizedBox(
            height: 150,
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 34,
                  width: 34,
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withOpacity(.8),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${qty}x $name',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        data,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
