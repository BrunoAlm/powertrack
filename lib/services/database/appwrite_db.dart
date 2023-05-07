// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/model/equipment_model.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';

class AppwriteDB {
  final AppwriteAuth _appwrite;
  final String databaseId;
  final String collectionId;
  late Databases database = Databases(_appwrite.client);

  AppwriteDB(this._appwrite, this.databaseId, this.collectionId);

  Future<void> createDocument(Map data) async {
    await database.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: ID.unique(),
      data: data,
    );
  }

  Future<List<EquipmentModel>> listDocuments() async {
    print("listDocuments()");
    var result = await database.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
    );

    print(
        "listDocuments() - result: ${result.documents.map((e) => e.data['name'])}");
    List<EquipmentModel> parse = [];
    result.documents.asMap().forEach((key, value) {
      parse.add(EquipmentModel.fromMap(value.data));
    });
    return parse;
  }

  Future deleteDocument(String documentId) async {
    print(
        'Deleting document $documentId from collection $collectionId in database $databaseId');
    await database.deleteDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );
    print(
        'Document $documentId deleted from collection $collectionId in database $databaseId');
  }

  Future<void> updateDocument(String document, Map data) async {
    await database.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: document,
      data: data,
    );
  }
}
