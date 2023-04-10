import 'package:appwrite/appwrite.dart';
import 'package:uitcc/app/auth/constants.dart';

class AppwriteAuth {
  final String endpoint;
  final String projectID;
  Client client = Client();
  late Account account = Account(client);
  late Databases database = Databases(client);

  AppwriteAuth({required this.endpoint, required this.projectID});

  Future<Client> initClient() async {
    client
        .setEndpoint(endpoint) // Your Appwrite Endpoint
        .setProject(projectID) // Your project ID
        .setSelfSigned(
          status: true,
        ); // For self signed certificates, only use for development
    account = Account(client);
    print(endpoint);

    return client;
  }

  // Future checkIsLoggedIn() async {
  //   try {
  //     var res = await account.get();
  //     print(res.status);
  //   } on AppwriteException catch (e) {
  //     print(e.message);
  //   }
  // }

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
  }

  Future login(String email, String password) async {
    // create account session
    await account.createEmailSession(email: email, password: password);
  }

  Future logout() async {
    // delete account session
    await account.deleteSessions();
  }

  void fetchDatabase() async {
    final result = database.getDocument(
      databaseId: tccDatabaseId,
      collectionId: collectionDocumentsId,
      documentId: documentId,
    );
    result.then((response) {
      print(response.data);
    }).catchError((error) {
      print(error);
    });
  }
}
