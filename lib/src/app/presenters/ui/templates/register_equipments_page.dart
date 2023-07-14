// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/added_equipments.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/result_search.dart';
import 'package:uitcc/src/app/presenters/ui/atom/search_text_field.dart';
import 'package:uitcc/src/app/presenters/ui/states/search_equipment_state.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';

class RegisterEquipments extends StatefulWidget {
  const RegisterEquipments({
    Key? key,
  }) : super(key: key);
  @override
  RegisterEquipmentsState createState() => RegisterEquipmentsState();
}

class RegisterEquipmentsState extends State<RegisterEquipments> {
  @override
  Widget build(BuildContext context) {
    var ct = Modular.get<EquipmentsController>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(38.0, 38.0, 38.0, 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Quais destes equipamentos você tem em casa?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: ct.searchState,
                builder: (context, SearchEquipmentState state, child) =>
                    Container(
                  padding: const EdgeInsets.all(10),
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
                          equipmentsStore: ct,
                        ),
                      ),
                      state is SuccessSearchEquipmentState
                          ? ResultSearch(equipmentStore: ct)
                          : state is FailedSearchEquipmentState
                              ? const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text('Equipamento não cadastrado.'),
                                )
                              : const SizedBox(),
                    ],
                  ),
                ),
              ),
              AddedEquipments(equipmentsStore: ct),
              SizedBox(
                child: BackButton(
                  onPressed: () {
                    var toBeAdded = ct.equipmentsToBeAdded;
                    if (!ct.equipmentIsValid(toBeAdded)) {
                      ct.compareAndCreateDocument(toBeAdded);
                      Modular.to.pop();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Preencha corretamente os campos',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Ok'),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
