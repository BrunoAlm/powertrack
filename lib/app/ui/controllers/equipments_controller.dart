import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/equipments_raw_list.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/model/equipment_model.dart';
import 'package:uitcc/app/ui/states/add_equipment_state.dart';
import 'package:uitcc/app/ui/states/search_equipment_state.dart';
import 'package:uitcc/services/database/appwrite_db.dart';

class EquipmentsController extends ChangeNotifier {
  final AppwriteDB _appwriteDb;
  List<EquipmentModel> loadedEquipments = [];
  List<EquipmentModel> searchedEquipments = [];
  List<EquipmentModel> equipmentsToBeAdded = [];

  // For search box
  final filteredEquipmentsName = ValueNotifier<List<String>>(equipmentsRawList);
  var searchState =
      ValueNotifier<SearchEquipmentState>(PendingSearchEquipmentState());
  var addState = ValueNotifier<AddEquipmentState>(PendingAddEquipmentState());

  final searchEC = TextEditingController();
  EquipmentsController(this._appwriteDb);

  void add({
    required String name,
    required int qty,
    required TimeOfDay? time,
    required TextEditingController power,
  }) {
    equipmentsToBeAdded.add(
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
              .contains(searchEC.value.text.toLowerCase()) &&
          equipmentsToBeAdded.any(
            (element) => element.name != equipmentName,
          );
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
      loadedEquipments = await _appwriteDb.listDocuments();
    } catch (e) {
      print(e);
    }
    // Notify listeners to redraw the UI.
    notifyListeners();
  }

  Future<void> createDocument(List<EquipmentModel> equipments) async {
    // Create a new document in the collection.
    try {
      for (var equipment in equipments) {
        await _appwriteDb.createDocument(equipment.toMap());
      }
    } on AppwriteException catch (e) {
      print(e.message);
    }
    listDocuments();
  }

  // compare and create if doesn't exist
  Future<void> compareAndCreateDocument(
      List<EquipmentModel> equipmentsToBeAdded) async {
    // Create a new document in the collection.
    try {
      for (var equipment in equipmentsToBeAdded) {
        // Get a list of all documents in the collection
        await listDocuments();
        // Check if the document already exists
        if (loadedEquipments.any((doc) => doc.name == equipment.name)) {
          print('document ${equipment.name} already exists');
          // If it does, update the document
          await _appwriteDb.updateDocument(
              document: loadedEquipments
                  .firstWhere((doc) => doc.name == equipment.name)
                  .id,
              data: equipment.toMap());
        } else {
          print('creating document ${equipment.name}');
          await _appwriteDb.createDocument(equipment.toMap());
        }
      }
    } on AppwriteException catch (e) {
      print(e.message);
    }
    listDocuments();
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      await _appwriteDb.deleteDocument(documentId);
      print('deletou o $documentId');
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  // delete all documents in the collection
  Future<void> deleteAllDocuments() async {
    try {
      // Get a list of all documents in the collection
      await listDocuments();
      print('deleting all documents');
      // Delete each document
      for (var doc in loadedEquipments) {
        print('deleting document ${doc.id}');
        await _appwriteDb.deleteDocument(doc.id);
      }
      print('done deleting');
      // Refresh the list of documents
      await listDocuments();
    } on AppwriteException catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateDocument({
    required String documentId,
    required String id,
    required String name,
    required int qty,
    required TimeOfDay? time,
    required TextEditingController power,
  }) async {
    try {
      await _appwriteDb.updateDocument(
          document: documentId,
          data: EquipmentModel(
            id: id,
            name: name,
            qty: qty,
            time: time,
            power: power,
          ).toMap());
    } on AppwriteException catch (e) {
      // Print the error message from Appwrite
      print(e.message);
    }
    // Refresh the list of documents
    listDocuments();
  }

  int totalPower() {
    int totalPower = 0;
    // se minha lista de equipamentos não está vazia
    if (loadedEquipments.isNotEmpty) {
      // percorro ela e verifico se a quantidade de cada item é maior que 1
      for (var item in loadedEquipments) {
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
    if (loadedEquipments.isNotEmpty) {
      // percorro ela e verifico se a quantidade de cada item é maior que 1
      for (var i = 0; i < loadedEquipments.length; i++) {
        int qty;
        qty = loadedEquipments[i].qty;
        result += qty;
      }
      return result;
    }
    return result;
  }

  int individualTotalPower(String name) {
    int totalPower = 0;
    for (var item
        in loadedEquipments.where((equipment) => equipment.name == name)) {
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
}
