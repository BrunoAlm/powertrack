import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/core/services/theme/color_schemes.g.dart';
import 'package:uitcc/src/core/data/datasources/appwrite_auth.dart';

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
      title: 'PowerTrack',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: lightColorScheme,
        cardTheme: const CardTheme(
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFC5F8FF),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: GoogleFonts.inter().fontFamily,
        cardTheme: const CardTheme(
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFC5F8FF),
        ),
      ),
      themeMode: lCt.changeThemeMode(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
