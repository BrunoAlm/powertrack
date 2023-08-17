import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';

enum CardType { time, consumption, cost, qty }

class ListViewEquipmentData extends StatelessWidget {
  final String title;
  final EquipmentsController equipCt;
  final LoginController loginCt;
  final CardType cardType;

  const ListViewEquipmentData({
    Key? key,
    required this.title,
    required this.equipCt,
    required this.cardType,
    required this.loginCt,
  }) : super(key: key);

  String getValue({
    required CardType cardType,
    required List<EquipmentModel> sortedEquipments,
    required int index,
    required LoginController loginCt,
  }) {
    final tax = loginCt.userPrefs.tax;
    final equipment = sortedEquipments[index];

    switch (cardType) {
      case CardType.consumption:
        double result = equipCt.individualConsumption(equipment.name);
        return '${Helper.formatDouble(result)} kWh';
      case CardType.cost:
        double cost = equipCt.individualCost(equipment.name, tax);
        String result = 'R\$ ${Helper.formatDouble(cost)}';
        if (cost == 0) {
          result = 'Taxa inválida';
        }
        return result;
      case CardType.time:
        return Helper.formatHour(equipment.time);

      case CardType.qty:
        return equipment.qty.toString();
      default:
        return '';
    }
  }

  IconData getIcon(CardType cardType) {
    switch (cardType) {
      case CardType.consumption:
        return Icons.bolt_rounded;
      case CardType.cost:
        return Icons.attach_money_rounded;
      case CardType.time:
        return Icons.access_time_filled_sharp;
      case CardType.qty:
        return Icons.stacked_bar_chart_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<EquipmentModel> equipments = equipCt.loadedEquipments;

    // Obtenha a lista de equipamentos ordenada com base no tipo de card
    List<EquipmentModel> sortedEquipments;

    // Taxa da concessionaria do usuario
    double tax = loginCt.userPrefs.tax;

    switch (cardType) {
      case CardType.consumption:
        sortedEquipments = [...equipments]..sort((a, b) {
            double consumptionA = equipCt.individualConsumption(a.name);
            double consumptionB = equipCt.individualConsumption(b.name);
            return consumptionB.compareTo(consumptionA);
          });
        break;
      case CardType.cost:
        sortedEquipments = [...equipments]..sort((a, b) {
            double costA = equipCt.individualCost(a.name, tax);
            double costB = equipCt.individualCost(b.name, tax);
            return costB.compareTo(costA);
          });
        break;
      case CardType.time:
        sortedEquipments = [...equipments]
          ..sort((a, b) => a.time.compareTo(b.time));
        break;
      case CardType.qty:
        sortedEquipments = [...equipments]
          ..sort((a, b) => a.qty.compareTo(b.qty));
        break;
      default:
        sortedEquipments = equipments;
    }

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
            itemCount: equipments.length,
            padding: const EdgeInsets.only(right: 16, left: 16, top: 5),
            itemBuilder: (context, index) {
              String name = equipments[index].name;
              int qty = equipments[index].qty;

              String value = getValue(
                cardType: cardType,
                sortedEquipments: sortedEquipments,
                index: index,
                loginCt: loginCt,
              );

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
                              height: 32,
                              width: 32,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withOpacity(.8),
                              ),
                              child: Icon(
                                getIcon(cardType),
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
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    value,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!,
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
