// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/features/app/features/home/presenter/ui/molecules/listview_equipment_card.dart';
import 'package:uitcc/src/features/app/features/home/presenter/ui/atom/overall_consumption_card.dart';

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
                    equipCt: widget.equipmentsStore,
                    loginCt: widget.loginController,
                  ),
                  ListViewEquipmentData(
                    cardType: CardType.consumption,
                    title: 'Consumo',
                    equipCt: widget.equipmentsStore,
                    loginCt: widget.loginController,
                  ),
                  ListViewEquipmentData(
                    cardType: CardType.time,
                    title: 'Tempo de uso',
                    equipCt: widget.equipmentsStore,
                    loginCt: widget.loginController,
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
