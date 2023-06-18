import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/ui/modules/home_module.dart';
import 'package:uitcc/src/app/presenters/ui/modules/recover_password_module.dart';
import 'package:uitcc/src/app/presenters/ui/modules/register_module.dart';
import '../pages/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
        ModuleRoute('/register', module: RegisterModule()),
        ModuleRoute('/recover-password', module: RecoverPasswordModule()),
        ModuleRoute('/home', module: HomeModule())
      ];
}
