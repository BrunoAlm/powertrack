// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/api/equipments_api.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/model/equipment_model.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/states/search_equipment_state.dart';

class EquipmentsStore extends ChangeNotifier {
  final List<EquipmentModel> equipments = [];

  final filteredEquipmentsName = ValueNotifier<List<String>>(equipmentsApi);
  var state =
      ValueNotifier<SearchEquipmentState>(PendingSearchEquipmentState());
  final searchEC = TextEditingController();

  void add({
    required String name,
    required int qty,
    required TimeOfDay? time,
    required TextEditingController power,
  }) {
    equipments.add(
      EquipmentModel(
        name: name,
        qty: qty,
        time: time,
        power: power,
      ),
    );
    notifyListeners();
  }

  Future<void> performSearch() async {
    state.value = LoadingSearchEquipmentState();

    filteredEquipmentsName.value = equipmentsApi.where((equipmentName) {
      return equipmentName
          .toLowerCase()
          .contains(searchEC.value.text.toLowerCase());
    }).toList();

    state.value = SuccessSearchEquipmentState();

    if (searchEC.value.text.isEmpty) {
      state.value = PendingSearchEquipmentState();
    }
    if (filteredEquipmentsName.value.isEmpty) {
      state.value = FailedSearchEquipmentState();
    }

    notifyListeners();
  }
}
