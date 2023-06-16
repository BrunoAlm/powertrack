import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/shared/theme/theme_service.dart';
import 'package:uitcc/services/auth/appwrite_auth.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    ThemeService().addListener(() {
      setState(() {});
      print('Tema atualizado.');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Modular.get<AppwriteAuth>().initClient();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromARGB(255, 10, 144, 222),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 25,
              ),
            ),
          )),
      // theme: ThemeService().returnThemeData(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
