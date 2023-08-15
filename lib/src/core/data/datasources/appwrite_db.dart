import 'package:appwrite/appwrite.dart';
import 'package:logger/logger.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';
import 'package:uitcc/src/core/data/datasources/appwrite_auth.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class AppwriteDB {
  final AppwriteAuth _appwrite;
  final String databaseId;
  final String documentsCollectionId;
  final String userPrefsCollectionId;
  final logger = Logger();
  late Databases database = Databases(_appwrite.client);
  AppwriteDB(this._appwrite, this.databaseId, this.documentsCollectionId,
      this.userPrefsCollectionId);

  Future<void> createDocument(Map data) async {
    await database.createDocument(
      databaseId: databaseId,
      collectionId: documentsCollectionId,
      documentId: Helper.idGenerator(),
      data: data,
    );
    logger.i('adicionado ${data['name']}');
  }

  Future<List<EquipmentModel>> listDocuments() async {
    var result = await database.listDocuments(
      databaseId: databaseId,
      collectionId: documentsCollectionId,
    );
    logger.i(
        "equipamentos no banco ${result.documents.map((e) => e.data['name'])}");

    List<EquipmentModel> parse = [];
    result.documents.asMap().forEach((key, value) {
      parse.add(EquipmentModel.fromMap(value.data));
    });

    return parse;
  }

  Future deleteDocument(String documentId) async {
    await database.deleteDocument(
      databaseId: databaseId,
      collectionId: documentsCollectionId,
      documentId: documentId,
    );
    logger.i('removido $documentId do banco');
  }

  Future<void> updateDocument(
      {required String document, required Map<String, dynamic> data}) async {
    await database.updateDocument(
      databaseId: databaseId,
      collectionId: documentsCollectionId,
      documentId: document,
      data: data,
    );
    logger.i('atualizado ${data['equipment']}');
  }
}
