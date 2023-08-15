import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/features/login/presenters/ui/pages/recover_password_page.dart';

class RecoverPasswordModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const RecoverPasswordPage()),
      ];
}
