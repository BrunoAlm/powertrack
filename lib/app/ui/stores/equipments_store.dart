// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/equipments_raw_list.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/model/equipment_model.dart';
import 'package:uitcc/app/ui/states/add_equipment_state.dart';
import 'package:uitcc/app/ui/states/search_equipment_state.dart';
import 'package:uitcc/services/database/appwrite_db.dart';

class EquipmentsStore extends ChangeNotifier {
  final AppwriteDB _appwriteDb;
  List<EquipmentModel> equipments = [];
  final filteredEquipmentsName = ValueNotifier<List<String>>(equipmentsRawList);
  var searchState =
      ValueNotifier<SearchEquipmentState>(PendingSearchEquipmentState());
  var addState = ValueNotifier<AddEquipmentState>(PendingAddEquipmentState());

  final searchEC = TextEditingController();
  EquipmentsStore(this._appwriteDb);

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
    searchState.value = LoadingSearchEquipmentState();

    filteredEquipmentsName.value = equipmentsRawList.where((equipmentName) {
      return equipmentName
          .toLowerCase()
          .contains(searchEC.value.text.toLowerCase());
    }).toList();

    searchState.value = SuccessSearchEquipmentState();

    if (searchEC.value.text.isEmpty) {
      searchState.value = PendingSearchEquipmentState();
    }
    if (filteredEquipmentsName.value.isEmpty) {
      searchState.value = FailedSearchEquipmentState();
    }

    notifyListeners();
  }

  Future<void> listDocuments() async {
    var result = await _appwriteDb.listDocuments();
    for (var element in result.documents) {
      equipments.add(EquipmentModel.fromMap(element.data));
    }
    notifyListeners();
  }

  Future<void> createDocument(List<EquipmentModel> equipments) async {
    // TODO: PRECISA SALVAR ESSA BAGAÇA A CADA TANTOS SEGUNDOS, VAI QUE O CARA FECHA O APP
    try {
      for (var e in equipments) {
        await _appwriteDb.createDocument(e.toMap());
      }
    } on AppwriteException catch (e) {
      print(e.message);
    }
    notifyListeners();
  }

  Future<void> deleteAllDocuments() async {
    var result = await _appwriteDb.listDocuments();
    try {
      for (var doc in result.documents) {
        await _appwriteDb.deleteDocument(doc.$id);
        print(doc.$id);
      }
      await listDocuments();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  int totalPower() {
    int result = 0;
    // se minha lista de equipamentos não está vazia
    if (equipments.isNotEmpty) {
      // percorro ela e verifico se a quantidade de cada item é maior que 1
      for (var i = 0; i < equipments.length; i++) {
        if (equipments[i].qty > 1) {
          // se for maior que um eu percorro essa lista somando cada 'power' na variável result
          for (var j = 0; j < equipments[i].qty; j++) {
            int power = int.parse(equipments[i].power.text);
            result += power;
          }
        } else {
          // se não foi maior que um, somente somo o 'power' na variável result
          int power = int.parse(equipments[i].power.text);
          result += power;
        }
      }
      return result;
    }
    return result;
  }

  int totalEquipments() {
    int result = 0;
    // se minha lista de equipamentos não está vazia
    if (equipments.isNotEmpty) {
      // percorro ela e verifico se a quantidade de cada item é maior que 1
      for (var i = 0; i < equipments.length; i++) {
        int qty;
        qty = equipments[i].qty;
        result += qty;
      }
      return result;
    }
    return result;
  }
}
