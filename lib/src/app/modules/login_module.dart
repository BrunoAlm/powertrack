import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/modules/home_module.dart';
import 'package:uitcc/src/app/modules/recover_password_module.dart';
import 'package:uitcc/src/app/modules/register_module.dart';
import '../presenters/ui/pages/login_page.dart';

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
