// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/templates/register_equipments_page.dart';

class EquipmentsNavigationPage extends StatefulWidget {
  final EquipmentsController equipmentsStore;
  const EquipmentsNavigationPage({
    Key? key,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  State<EquipmentsNavigationPage> createState() =>
      _EquipmentsNavigationPageState();
}

class _EquipmentsNavigationPageState extends State<EquipmentsNavigationPage> {
  @override
  void initState() {
    if (widget.equipmentsStore.equipmentsToBeAdded.isEmpty) {
      widget.equipmentsStore.equipmentsToBeAdded =
          widget.equipmentsStore.loadedEquipments;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var equipments = widget.equipmentsStore.loadedEquipments;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 58,
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).disabledColor),
            ),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Text('Nome do equipamento'),
                      SizedBox(width: 20),
                      Text('Quantidade'),
                      SizedBox(width: 20),
                      Text('Potência'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      equipments.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: index == 0
                                ? BorderSide(
                                    color: Theme.of(context).disabledColor,
                                  )
                                : BorderSide.none,
                            left: BorderSide(
                              color: Theme.of(context).disabledColor,
                            ),
                            right: BorderSide(
                              color: Theme.of(context).disabledColor,
                            ),
                            bottom: BorderSide(
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 205,
                              child: Text(
                                equipments[index].name,
                              ),
                            ),
                            SizedBox(
                              width: 65,
                              child: Text(
                                equipments[index].qty.toString(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              equipments[index].power.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const RegisterEquipments(),
                ),
            label: const Text('Alterar'),
            icon: const Icon(Icons.edit_rounded)),
      ),
    );
  }
}
