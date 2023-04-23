import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/cadastrar_dados_screen.dart';
import 'package:uitcc/app/ui/pages/home/home_page.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';
import 'package:uitcc/app/ui/pages/profile/profile_module.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => EquipmentsStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const CadastrarDadosScreen()),
        ChildRoute('/home-page', child: (context, args) => const HomePage()),
        ModuleRoute('/profile', module: ProfileModule()),
      ];
}
