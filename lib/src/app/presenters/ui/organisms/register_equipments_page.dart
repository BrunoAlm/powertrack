// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/ui/atom/active_button.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/added_equipments.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/result_search.dart';
import 'package:uitcc/src/app/presenters/ui/atom/search_text_field.dart';
import 'package:uitcc/src/app/presenters/ui/states/search_equipment_state.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';

class RegisterEquipmentsPage extends StatefulWidget {
  const RegisterEquipmentsPage({
    Key? key,
  }) : super(key: key);
  @override
  RegisterEquipmentsPageState createState() => RegisterEquipmentsPageState();
}

class RegisterEquipmentsPageState extends State<RegisterEquipmentsPage> {
  @override
  Widget build(BuildContext context) {
    var equipmentCt = Modular.get<EquipmentsController>();
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
                valueListenable: equipmentCt.searchState,
                builder: (context, SearchEquipmentState state, child) =>
                    Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    color: state is SuccessSearchEquipmentState ||
                            state is FailedSearchEquipmentState
                        ? Theme.of(context).colorScheme.primaryContainer
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
                          equipmentsStore: equipmentCt,
                        ),
                      ),
                      state is SuccessSearchEquipmentState
                          ? ResultSearch(
                              ct: equipmentCt,
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
              AddedEquipments(equipmentsCt: equipmentCt),
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
                  equipmentCt
                      .compareAndCreateDocument(equipmentCt.equipmentsToBeAdded)
                      .then(
                    (value) {
                      equipmentCt.equipmentsToBeAdded.clear();
                      Navigator.of(context).pop();
                    },
                  );
                },
                text: 'Salver',
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
