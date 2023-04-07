import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/cadastrar_dados_screen.dart';
import 'package:uitcc/app/pages/home/home_page_screen.dart';
import 'package:uitcc/app/pages/profile/profile_module.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/cadastrar_dados',
            child: (context, args) => const CadastrarDadosScreen()),
        ModuleRoute('/profile', module: ProfileModule())
      ];
}
