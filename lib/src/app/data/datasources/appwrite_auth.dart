import 'package:appwrite/appwrite.dart';
import 'package:uitcc/src/app/data/dtos/user_dto.dart';
import 'package:uitcc/src/app/domain/entities/user_entity.dart';
import 'package:uitcc/src/app/domain/entities/user_prefs_entity.dart';

class AppwriteAuth {
  final String endpoint;
  final String projectID;
  Client client = Client();
  late Account account = Account(client);

  AppwriteAuth({required this.endpoint, required this.projectID});

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

  Future checkIsLoggedIn() async {
    await account.get();
  }

  Future register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Create user account
    await account.create(
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

  Future<UserEntity> getUser() async {
    var result = await account.get();
    UserEntity parse = UserDto.fromJson(result.toMap());
    return parse;
  }

  Future<UserPrefsEntity> getUserPref() async {
    var result = await account.getPrefs();
    return UserPrefsEntity.fromMap(result.data);
  }

  Future<void> updateUserPref(UserPrefsEntity prefs) async {
    UserPrefsEntity userPrefsEntity =
        UserPrefsEntity(theme: prefs.theme, tax: prefs.tax);
    await account.updatePrefs(prefs: userPrefsEntity.toMap());
  }
}
