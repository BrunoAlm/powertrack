// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/widgets/added_equipments.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/widgets/result_search.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/widgets/search_text_field.dart';
import 'package:uitcc/app/ui/states/search_equipment_state.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';

class RegisterEquipments extends StatefulWidget {
  final EquipmentsStore equipmentsStore;
  final double widgetHeight;
  const RegisterEquipments({
    Key? key,
    required this.equipmentsStore,
    required this.widgetHeight,
  }) : super(key: key);
  @override
  _RegisterEquipmentsState createState() => _RegisterEquipmentsState();
}

class _RegisterEquipmentsState extends State<RegisterEquipments> {
  // @override
  // void initState() {
  //   widget.equipmentsStore.addListener(() {
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(38.0, 38.0, 38.0, 0),
      child: SizedBox(
        height: widget.widgetHeight,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Quais destes equipamentos você tem em casa?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: widget.equipmentsStore.searchState,
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
                          equipmentsStore: widget.equipmentsStore),
                    ),
                    state is SuccessSearchEquipmentState
                        ? ResultSearch(equipmentStore: widget.equipmentsStore)
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
            const SizedBox(height: 20),
            AddedEquipments(equipmentsStore: widget.equipmentsStore),
          ],
        ),
      ),
    );
  }
}
