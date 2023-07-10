// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/individual_consumption_card.dart';
import 'package:uitcc/src/app/presenters/ui/atom/overall_consumption_card.dart';
import 'package:uitcc/src/app/presenters/ui/atom/user_info_appbar.dart';

class DashboardNavigationpage extends StatefulWidget {
  final EquipmentsController equipmentsStore;
  final LoginController loginStore;
  const DashboardNavigationpage({
    Key? key,
    required this.equipmentsStore,
    required this.loginStore,
  }) : super(key: key);

  @override
  State<DashboardNavigationpage> createState() =>
      DashboardNavigationpageState();
}

class DashboardNavigationpageState extends State<DashboardNavigationpage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoAppBar(user: widget.loginStore.userConnected),
            const SizedBox(height: 40),
            OverallConsumptionCard(ct: widget.equipmentsStore),
            const SizedBox(height: 40),
            Column(
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
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.equipmentsStore.loadedEquipments.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: IndividualConsumptionCard(
                        equipmentConsumption: widget.equipmentsStore
                            .individualTotalPower(
                              widget
                                  .equipmentsStore.loadedEquipments[index].name,
                            )
                            .toString(),
                        equipmentName:
                            widget.equipmentsStore.loadedEquipments[index].name,
                        qty: widget.equipmentsStore.individualTotalQty(widget
                            .equipmentsStore.loadedEquipments[index].name),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}