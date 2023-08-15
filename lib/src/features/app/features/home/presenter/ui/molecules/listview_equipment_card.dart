import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

enum CardType { time, consumption, cost }

class ListViewEquipmentData extends StatelessWidget {
  final String title;
  final int itemCount;
  final IconData cardIcon;
  final List<EquipmentModel> equipments;
  final CardType cardType;
  final Function(String)? calcFunc;
  final double? tax;
  final Function(String, double)? calcCost;

  const ListViewEquipmentData({
    Key? key,
    required this.title,
    required this.itemCount,
    required this.cardIcon,
    required this.equipments,
    required this.cardType,
    this.calcFunc,
    this.tax,
    this.calcCost,
  }) : super(key: key);

  static String getValue(
    CardType cardType,
    EquipmentModel equipment,
    Function(String)? calcFunc,
    double? tax,
    Function(String, double)? calcCost,
  ) {
    switch (cardType) {
      case CardType.consumption:
        return '${Helper.formatDouble(calcFunc!(equipment.name))}kWh';
      case CardType.time:
        return Helper.formatHour(equipment.time);
      case CardType.cost:
        return 'R\$ ${Helper.formatDouble(calcCost!(equipment.name, tax!))}';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge!),
              Container(
                height: 1.5,
                width: 160,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            padding: const EdgeInsets.only(right: 16, left: 16, top: 5),
            itemBuilder: (context, index) {
              var name = equipments[index].name;
              var qty = equipments[index].qty;
              return Container(
                margin: const EdgeInsets.only(right: 10, bottom: 10),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: ThemeHelper.shadow(context),
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10),
                      child: SizedBox(
                        height: 120,
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
                                cardIcon,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${qty}x $name',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    getValue(
                                      cardType,
                                      equipments[index],
                                      calcFunc,
                                      tax,
                                      calcCost,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
