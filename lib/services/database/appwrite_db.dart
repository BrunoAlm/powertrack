// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';

class AppwriteDB {
  final AppwriteAuth _appwrite;
  final String databaseId;
  final String collectionId;
  final String documentId = ID.unique();
  late Databases database = Databases(_appwrite.client);
  AppwriteDB(this._appwrite, this.databaseId, this.collectionId);

  Future<void> createDocument(Map data) async {
    await database.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
      data: data,
    );
  }
}
