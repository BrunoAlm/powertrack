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
      title: 'Meu App',
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
      ),
      themeMode: lCt.changeThemeMode(),
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: const ColorScheme.dark().copyWith(
      //     background: const Color(0xff1e1e1e),
      //     // onBackground: const Color(0xff2d2d2d),
      //     primary: const Color(0xff0271ff),
      //     secondary: const Color(0xff2d2d2d),
      //   ),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       shape: ContinuousRectangleBorder(
      //           borderRadius: BorderRadius.circular(20)),
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 40,
      //         vertical: 25,
      //       ),
      //     ),
      //   ),
      // ),
      // theme: ThemeService().returnThemeData(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
