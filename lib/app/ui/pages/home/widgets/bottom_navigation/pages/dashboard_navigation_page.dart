// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';

class DashboardNavigationpage extends StatefulWidget {
  final EquipmentsStore equipmentsStore;
  const DashboardNavigationpage({
    Key? key,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  State<DashboardNavigationpage> createState() =>
      DashboardNavigationpageState();
}

class DashboardNavigationpageState extends State<DashboardNavigationpage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // Text(
          //     'Total de equipamentos: ${widget.equipmentsStore.totalEquipments()}'),
          // Text('Total de consumo: ${widget.equipmentsStore.totalPower()}'),
        ],
      ),
    );
  }
}
