import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/database/appwrite_db.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Modular.get<AppwriteDB>().initClient();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00509D),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 25,
            ),
          ),
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
