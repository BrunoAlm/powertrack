import 'package:flutter_modular/flutter_modular.dart';

import '../home_page/home_module.dart';
import 'login_page.dart';
import 'register_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
        ChildRoute('/register', child: (context, args) => const RegisterPage()),
        ModuleRoute('/home', module: HomeModule())
      ];
}
