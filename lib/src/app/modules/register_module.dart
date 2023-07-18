import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/controllers/register_controller.dart';
import 'package:uitcc/src/app/presenters/ui/pages/register_page.dart';

class RegisterModule extends Module {
  @override
  List<Bind> get binds => [Bind.factory((i) => RegisterController(i()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const RegisterPage()),
      ];
}
