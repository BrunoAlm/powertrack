import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/individual_equipment_card.dart';
import 'package:uitcc/src/app/presenters/ui/atom/overall_consumption_card.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OverallConsumptionCard(
              equipmentsController: widget.equipmentsStore,
              loginController: widget.loginController,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Consumo',
                        style: Theme.of(context).textTheme.titleLarge!),
                    Container(
                      height: 1.5,
                      width: 120,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.equipmentsStore.loadedEquipments.length,
                    padding: const EdgeInsets.only(right: 10),
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      child: IndividualEquipmentCard(
                        data:
                            '${Helper.formatDouble(widget.equipmentsStore.calculateIndividualConsumption(
                          widget.equipmentsStore.loadedEquipments[index].name,
                        ))}kWh',
                        name:
                            widget.equipmentsStore.loadedEquipments[index].name,
                        qty: widget.equipmentsStore.individualTotalQty(widget
                            .equipmentsStore.loadedEquipments[index].name),
                        icon: Icons.bolt_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tempo de uso',
                        style: Theme.of(context).textTheme.titleLarge!),
                    Container(
                      height: 1.5,
                      width: 160,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.equipmentsStore.loadedEquipments.length,
                    padding: const EdgeInsets.only(right: 10),
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      child: IndividualEquipmentCard(
                        data:
                            '${widget.equipmentsStore.individualTime(widget.equipmentsStore.loadedEquipments[index].name)}h',
                        name:
                            widget.equipmentsStore.loadedEquipments[index].name,
                        qty: widget.equipmentsStore.individualTotalQty(widget
                            .equipmentsStore.loadedEquipments[index].name),
                        icon: Icons.timer_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
