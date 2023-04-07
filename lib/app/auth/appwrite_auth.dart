// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:uitcc/app/auth/constants.dart';

class AppwriteAuth {
  AppwriteAuth({required this.endpoint, required this.projectID});
  final String endpoint;
  final String projectID;
  Client client = Client();
  late Account account = Account(client);

  Future<Client> initClient() async {
    client
        .setEndpoint(endpoint) // Your Appwrite Endpoint
        .setProject(projectID) // Your project ID
        .setSelfSigned(
          status: true,
        ); // For self signed certificates, only use for development
    account = Account(client);

    return client;
  }

  Future register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Create user account
    final user = await account.create(
      userId: ID.unique(),
      name: name,
      email: email,
      password: password,
    );
    print("Usuário ${user.name} criado com sucesso!");
  }

  Future login(String email, String password) async {
    // Login user
    await account.createEmailSession(email: email, password: password);
  }

  void fetchDatabase() async {
    Databases databases = Databases(client);
    Future result = databases.listDocuments(
      databaseId: tccDatabaseId,
      collectionId: collectionUsersId,
    );
    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
    });
  }
}
