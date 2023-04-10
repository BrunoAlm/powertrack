import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/states/search_equipment_state.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/widgets/added_equipments.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/widgets/result_search.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/widgets/search_text_field.dart';
import 'package:uitcc/app/pages/home/store/equipments_store.dart';

class RegisterEquipments extends StatefulWidget {
  const RegisterEquipments({Key? key}) : super(key: key);
  @override
  _RegisterEquipmentsState createState() => _RegisterEquipmentsState();
}

class _RegisterEquipmentsState extends State<RegisterEquipments> {
  final EquipmentsStore equipmentsStore = Modular.get();

  @override
  void initState() {
    equipmentsStore.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(38.0, 38.0, 38.0, 0),
      child: SizedBox(
        height: _altura,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Quais destes equipamentos você tem em casa?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: equipmentsStore.state,
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
                      child: SearchTextField(equipmentsStore: equipmentsStore),
                    ),
                    state is SuccessSearchEquipmentState
                        ? ResultSearch(equipmentStore: equipmentsStore)
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
            AddedEquipments(equipmentsStore: equipmentsStore),
          ],
        ),
      ),
    );
  }
}
