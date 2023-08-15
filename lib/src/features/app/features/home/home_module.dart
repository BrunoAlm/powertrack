import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/features/app/ui/pages/app_page.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/home/presenter/store/home_store.dart';
import 'package:uitcc/src/core/services/appwrite_constants.dart';
import 'package:uitcc/src/core/data/datasources/appwrite_db.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => AppwriteDB(
            i(), databaseId, equipmentsCollectionId, userPrefsCollectionId)),
        Bind.singleton((i) => EquipmentsController(i())),
        Bind.singleton((i) => AppStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
