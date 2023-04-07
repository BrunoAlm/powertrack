import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/login/login_module.dart';
import 'package:uitcc/database/appwrite_db.dart';
import 'package:uitcc/database/constants.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
            (i) => AppwriteDB(endpoint: endpoint, projectID: projectId)),
      ];


  @override
  List<ModularRoute> get routes => [ModuleRoute('/', module: LoginModule())];
}
