// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/api/equipments_api.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/model/equipment_model.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/states/search_equipment_state.dart';

class EquipmentsStore extends ChangeNotifier {
  final List<EquipmentModel> equipments = [];
  final filteredEquipments = ValueNotifier<List<String>>(equipmentsApi);
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
        id: Random().nextInt(1000),
        name: name,
        qty: qty,
        time: time,
        power: power,
      ),
    );
    notifyListeners();
  }

  void remove(int id) {
    equipments.removeWhere((equipment) => equipment.id == id);
    performSearch();
    notifyListeners();
  }

  Future<void> performSearch() async {
    state.value = LoadingSearchEquipmentState();

    filteredEquipments.value = equipmentsApi.where((equipment) {
      return equipment
          .toLowerCase()
          .contains(searchEC.value.text.toLowerCase());
    }).toList();

    state.value = SuccessSearchEquipmentState();

    if (searchEC.value.text.isEmpty) {
      state.value = PendingSearchEquipmentState();
    }
    if (filteredEquipments.value.isEmpty) {
      state.value = FailedSearchEquipmentState();
    }

    notifyListeners();
  }

  void removeIfExist({required int index}) {
    filteredEquipments.value.removeAt(index);
    notifyListeners();
  }
}
