import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uitcc/src/core/data/equipments_raw_list.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/states/add_equipment_state.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/states/search_equipment_state.dart';
import 'package:uitcc/src/core/data/datasources/appwrite_db.dart';

class EquipmentsController extends ChangeNotifier {
  final AppwriteDB _appwriteDb;
  List<EquipmentModel> loadedEquipments = [];
  List<EquipmentModel> searchedEquipments = [];
  List<EquipmentModel> equipmentsToBeAdded = [];
  var logger = Logger();

  // For search box
  final filteredEquipmentsName = ValueNotifier<List<String>>(equipmentsRawList);
  var searchState =
      ValueNotifier<SearchEquipmentState>(PendingSearchEquipmentState());
  var addState = ValueNotifier<AddEquipmentState>(PendingAddEquipmentState());

  final searchEC = TextEditingController();
  EquipmentsController(this._appwriteDb);

  void add({
    required String id,
    required String name,
    required int qty,
    required DateTime time,
    required int power,
  }) {
    equipmentsToBeAdded.add(
      EquipmentModel(
        id: id,
        name: name,
        qty: qty,
        time: time,
        power: power,
      ),
    );
    notifyListeners();
  }

  /// Pesquisa na lista `equipmentsRawList` e adiciona na lista `filteredEquipmentsName`
  Future<void> performSearch() async {
    searchState.value = LoadingSearchEquipmentState();
    equipmentsRawList.removeWhere(
      (raw) =>
          equipmentsToBeAdded.any((tobe) => tobe.name == raw) ||
          loadedEquipments.any((loaded) => loaded.name == raw),
    );

    filteredEquipmentsName.value = equipmentsRawList.where((equipmentName) {
      return equipmentName.toLowerCase().contains(
            searchEC.value.text.toLowerCase(),
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
      logger.e(e);
    }
    // Notify listeners to redraw the UI.
    notifyListeners();
  }

  // compare and create if doesn't exist
  Future<void> compareAndCreateDocument(
      List<EquipmentModel> equipmentsToBeAdded) async {
    // Create a new document in the collection.
    try {
      for (var toBeAdded in equipmentsToBeAdded) {
        // Get a list of all documents in the collection
        await listDocuments();
        // Check if the document already exists
        if (loadedEquipments.any((doc) => doc.name == toBeAdded.name)) {
          logger.i('equipamento ${toBeAdded.name} já existe');
          // If it does, update the document
          await _appwriteDb.updateDocument(
              document: loadedEquipments
                  .firstWhere((doc) => doc.name == toBeAdded.name)
                  .id,
              data: toBeAdded.toMap());
        } else {
          logger.i('adicionando ${toBeAdded.name}');
          await _appwriteDb.createDocument(toBeAdded.toMap());
        }
      }
    } on AppwriteException catch (e) {
      logger.e(e.message);
    }
    listDocuments();
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      await _appwriteDb.deleteDocument(documentId);
      listDocuments();
      logger.i('deletou o equipamento com ID $documentId');
    } on AppwriteException catch (e) {
      logger.e(e.message);
    }
  }

  // delete all documents in the collection
  Future<void> deleteAllDocuments() async {
    try {
      // Get a list of all documents in the collection
      await listDocuments();
      logger.i('apagando todos os equipamentos');
      // Delete each document
      for (var doc in loadedEquipments) {
        logger.i('apagou ${doc.name}');
        await _appwriteDb.deleteDocument(doc.id);
      }
      logger.i('apagou tudo');
      // Refresh the list of documents
      await listDocuments();
    } on AppwriteException catch (e) {
      logger.e(e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> updateDocument({
    required EquipmentModel equipment,
  }) async {
    try {
      await _appwriteDb.updateDocument(
        document: equipment.id,
        data: equipment.toMap(),
      );
    } on AppwriteException catch (e) {
      // Print the error message from Appwrite
      logger.e(e.message);
    }
    // Refresh the list of documents
    listDocuments();
  }

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
          totalPower += item.power;
        }
      } else {
        // se não foi maior que um, somente somo o 'power' na variável result
        totalPower += item.power;
      }
    }
    return totalPower;
  }

  double individualConsumption(String name) {
    double consumptionKWh = 0.0;
    var items =
        loadedEquipments.where((equipment) => equipment.name == name).toList();

    if (items.isNotEmpty) {
      double powerKW = double.parse(individualTotalPower(name).toString());

      // Somamos o tempo de uso de todos os equipamentos
      double totalUsageHours = 0.0;
      for (var item in items) {
        double timeHours = item.time.hour + (item.time.minute / 60);
        totalUsageHours += timeHours;
      }

      // Calculamos o consumo mensal em kWh
      consumptionKWh = (powerKW * totalUsageHours * 30) / 1000;
    }

    return consumptionKWh;
  }

  double totalConsumption() {
    double total = 0;
    if (loadedEquipments.isNotEmpty) {
      for (var i = 0; i < loadedEquipments.length; i++) {
        double kwh;
        kwh = individualConsumption(loadedEquipments[i].name);
        total += kwh;
      }
      return total;
    }
    return total;
  }

  double totalCost(double kWhRate) {
    double result = totalConsumption();
    double totalPayment = result * kWhRate;
    return totalPayment;
  }

  double individualCost(String name, double kWhRate) {
    double result = individualConsumption(name);
    double totalPayment = result * kWhRate;
    return totalPayment;
  }

}
