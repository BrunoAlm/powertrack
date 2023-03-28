import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/home_page/home_page_screen.dart';
import 'package:uitcc/app/profile_page/profile_module.dart';
import 'package:uitcc/app/home_page/cadastrar_dados/cadastrar_dados_screen.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/cadastrar_dados', child: (context, args) => const CadastrarDadosScreen()),
        ModuleRoute('/profile', module: ProfileModule())
      ];
}
