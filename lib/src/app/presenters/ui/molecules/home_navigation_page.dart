// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/listview_equipment_card.dart';
import 'package:uitcc/src/app/presenters/ui/atom/overall_consumption_card.dart';

class HomeNavigationPage extends StatefulWidget {
  final EquipmentsController equipmentsStore;
  final LoginController loginController;
  const HomeNavigationPage({
    Key? key,
    required this.equipmentsStore,
    required this.loginController,
  }) : super(key: key);

  @override
  State<HomeNavigationPage> createState() => HomeNavigationPageState();
}

class HomeNavigationPageState extends State<HomeNavigationPage> {
  @override
  Widget build(BuildContext context) {
    var equipments = widget.equipmentsStore.loadedEquipments;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: OverallConsumptionCard(
                equipmentsController: widget.equipmentsStore,
                loginController: widget.loginController,
              ),
            ),
            Visibility(
              visible: widget.equipmentsStore.loadedEquipments.isNotEmpty,
              replacement: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Text(
                  'Adicione equipamentos para visualizar os dados 😁',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ListViewEquipmentData(
                    cardType: CardType.cost,
                    title: 'Custo',
                    calcCost: widget.equipmentsStore.individualCost,
                    tax: widget.loginController.userPrefs.tax,
                    itemCount: equipments.length,
                    cardIcon: Icons.bolt_rounded,
                    equipments: equipments,
                  ),
                  ListViewEquipmentData(
                    cardType: CardType.consumption,
                    calcFunc: widget.equipmentsStore.individualConsumption,
                    title: 'Consumo',
                    itemCount: equipments.length,
                    cardIcon: Icons.bolt_rounded,
                    equipments: equipments,
                  ),
                  ListViewEquipmentData(
                    cardType: CardType.time,
                    calcFunc: widget.equipmentsStore.individualTime,
                    title: 'Tempo de uso',
                    itemCount: equipments.length,
                    cardIcon: Icons.bolt_rounded,
                    equipments: equipments,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
