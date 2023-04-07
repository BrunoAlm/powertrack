import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/home/cadastrar_dados/api/equipment_model/equipment.dart';
import 'package:uitcc/app/home/home_page_screen.dart';
import 'package:uitcc/app/profile/profile_module.dart';
import 'package:uitcc/app/home/cadastrar_dados/cadastrar_dados_screen.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
            (i) => Equipment(name: '', qty: 0, timeSpent: '', power: 0))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/cadastrar_dados',
            child: (context, args) => const CadastrarDadosScreen()),
        ModuleRoute('/profile', module: ProfileModule())
      ];
}
