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
  List<EquipmentModel> searchedEquipments = [];


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
        id: ID.unique(),
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
    // Get the list of all documents in the collection.
    try {
      equipments = await _appwriteDb.listDocuments();
    } catch (e) {
      print(e);
    }
    // Notify listeners to redraw the UI.
    notifyListeners();
  }

  Future<void> createDocument(List<EquipmentModel> equipments) async {
    try {
      for (var equipment in equipments) {
        await _appwriteDb.createDocument(equipment.toMap());
      }
    } on AppwriteException catch (e) {
      print(e.message);
    }
    listDocuments();
    notifyListeners();
  }

  // função que deleta todos os documentos do usuário
  Future<void> deleteAllDocuments() async {
    try {
      // Get a list of all documents in the collection
      await listDocuments();
      // Delete each document
      for (var doc in equipments) {
        print(doc.id);
        await _appwriteDb.deleteDocument(doc.id);
      }

      // Refresh the list of documents
      await listDocuments();
    } on AppwriteException catch (e) {
      print('ue');
      print(e.message);
    }
    notifyListeners();
  }

  int totalPower() {
    int totalPower = 0;
    // se minha lista de equipamentos não está vazia
    if (equipments.isNotEmpty) {
      // percorro ela e verifico se a quantidade de cada item é maior que 1
      for (var item in equipments) {
        if (item.qty > 1) {
          // se for maior que um eu percorro essa lista somando cada 'power' na variável result
          for (var i = 0; i < item.qty; i++) {
            var power = int.parse(item.power.text);
            totalPower += power;
          }
        } else {
          // se não foi maior que um, somente somo o 'power' na variável result
          var power = int.parse(item.power.text);
          totalPower += power;
        }
      }
      return totalPower;
    }
    return totalPower;
  }

  // função que mostra a quantidade total de equipamentos que o usuário possui
  // ela percorre a lista de equipamentos e soma a quantidade de cada item
  // caso não tenha nenhum item, a função retorna 0

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
