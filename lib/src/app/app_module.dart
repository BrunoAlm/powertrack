import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/modules/login_module.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/data/datasources/appwrite_auth.dart';
import 'package:uitcc/src/core/services/appwrite_constants.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
            (i) => AppwriteAuth(endpoint: endpoint, projectID: projectId)),
        Bind.singleton((i) => LoginController(i())),
      ];

  @override
  List<ModularRoute> get routes => [ModuleRoute('/', module: LoginModule())];
}
