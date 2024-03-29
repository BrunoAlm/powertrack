import 'package:appwrite/appwrite.dart';
import 'package:uitcc/src/features/login/domain/dtos/user_dto.dart';
import 'package:uitcc/src/features/login/domain/entity/user_entity.dart';
import 'package:uitcc/src/features/login/domain/entity/user_prefs_entity.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class AppwriteAuth {
  final String endpoint;
  final String projectID;
  Client client = Client();
  late Account account;
  late Storage storage;
  AppwriteAuth({required this.endpoint, required this.projectID});

  Future<Client> initClient() async {
    client
        .setEndpoint(endpoint) // Your Appwrite Endpoint
        .setProject(projectID); // Your project ID

    account = Account(client);
    storage = Storage(client);
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
      userId: Helper.idGenerator(),
      name: name,
      email: email,
      password: password,
    );
  }

  Future login(String email, String password) async {
    // create account session
    await account.createEmailSession(email: email, password: password);
  }

  Future logout(String id) async {
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
