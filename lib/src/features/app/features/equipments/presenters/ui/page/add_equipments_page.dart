import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/ui/atoms/active_button.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/organisms/added_equipments.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/organisms/search_result.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/search_text_field.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/states/search_equipment_state.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';

class AddEquipmentsPage extends StatefulWidget {
  final EquipmentsController equipmentCt;
  const AddEquipmentsPage({
    Key? key,
    required this.equipmentCt,
  }) : super(key: key);
  @override
  AddEquipmentsPageState createState() => AddEquipmentsPageState();
}

class AddEquipmentsPageState extends State<AddEquipmentsPage> {
  @override
  void dispose() {
    widget.equipmentCt.equipmentsToBeAdded.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ct = widget.equipmentCt;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Adicione seus equipamentos',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: ct.searchState,
                builder: (context, SearchEquipmentState state, child) =>
                    Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    color: state is SuccessSearchEquipmentState ||
                            state is FailedSearchEquipmentState
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: SearchTextField(
                          equipmentsStore: ct,
                        ),
                      ),
                      state is SuccessSearchEquipmentState
                          ? SearchResult(
                              ct: ct,
                            )
                          : state is FailedSearchEquipmentState
                              ? const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text('Equipamento não encontrado'),
                                )
                              : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AddedEquipments(equipmentsCt: ct),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActiveButton(
                onTap: () => Navigator.of(context).pop(),
                text: 'Voltar',
                icon: Icons.arrow_back,
                position: ActiveButtonPosition.left,
              ),
              ActiveButton(
                onTap: () {
                  ct.compareAndCreateDocument(ct.equipmentsToBeAdded).then(
                    (value) {
                      ct.equipmentsToBeAdded.clear();
                      Navigator.of(context).pop();
                    },
                  );
                },
                text: 'Salvar',
                position: ActiveButtonPosition.right,
                icon: Icons.save_outlined,
              )
            ],
          ),
        ),
      ),
    );
  }
}
