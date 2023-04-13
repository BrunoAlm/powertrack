import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/cadastrar_dados_screen.dart';
import 'package:uitcc/app/pages/home/home_page_screen.dart';
import 'package:uitcc/app/pages/home/store/equipments_store.dart';
import 'package:uitcc/app/pages/profile/profile_module.dart';
import 'package:uitcc/services/appwrite_constants.dart';
import 'package:uitcc/services/database/appwrite_db.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => EquipmentsStore()),
        Bind.factory((i) => AppwriteDB(i(), databaseId, collectionId)),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/cadastrar_dados',
            child: (context, args) => const CadastrarDadosScreen()),
        ModuleRoute('/profile', module: ProfileModule())
      ];
}
