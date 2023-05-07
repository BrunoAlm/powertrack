import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/cadastrar_dados_screen.dart';
import 'package:uitcc/app/ui/pages/home/home_page.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';
import 'package:uitcc/app/ui/stores/home_store.dart';
import 'package:uitcc/services/appwrite_constants.dart';
import 'package:uitcc/services/database/appwrite_db.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => AppwriteDB(i(), databaseId, collectionId)),
        Bind.singleton((i) => EquipmentsStore(i())),
        Bind.singleton((i) => HomeStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/cadastrar-dados',
            child: (context, args) => const CadastrarDadosScreen()),
      ];
}
