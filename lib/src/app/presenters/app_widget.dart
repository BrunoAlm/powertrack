import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/core/services/theme/color_schemes.g.dart';
// import 'package:uitcc/src/core/services/theme/theme_service.dart';
import 'package:uitcc/src/app/data/datasources/appwrite_auth.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var lCt = Modular.get<LoginController>();
  @override
  void initState() {
    super.initState();

    lCt.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Modular.get<AppwriteAuth>().initClient();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TCC - Uso de Energia',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
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
        appBarTheme: const AppBarTheme(
          color: Color(0xFFFDFBFF),
        ),
        cardTheme: const CardTheme(
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
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
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0e0f12),
        ),
        cardTheme: const CardTheme(
          elevation: 0,
        ),
      ),
      themeMode: lCt.changeThemeMode(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
