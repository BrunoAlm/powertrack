import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/pages/login/login_module.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';
import 'package:uitcc/services/appwrite_constants.dart';
import 'package:uitcc/services/database/appwrite_db.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
            (i) => AppwriteAuth(endpoint: endpoint, projectID: projectId)),
      ];

  @override
  List<ModularRoute> get routes => [ModuleRoute('/', module: LoginModule())];
}
