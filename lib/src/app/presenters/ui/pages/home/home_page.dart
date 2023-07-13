// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/ui/atom/user_info_appbar.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/bottom_navigation.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/settings_drawer.dart';
import 'package:uitcc/src/app/presenters/ui/pages/home/molecules/home_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/pages/home/molecules/equipments_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/pages/home/molecules/savings_navigation_page.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/home_store.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/presenters/ui/states/app_state.dart';
import 'package:uitcc/src/app/presenters/ui/templates/register_equipments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final LoginController _loginCt = Modular.get();
  final EquipmentsController _equipmentsCt = Modular.get();
  final HomeStore _homeStore = Modular.get();

  @override
  void initState() {
    super.initState();
    _homeStore.appState.value = LoadingAppState();
    try {
      _homeStore.addListener(() {
        setState(() {});
      });
      _equipmentsCt.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
      Future.wait([
        _loginCt.initUser(),
        _equipmentsCt.listDocuments(),
      ]).then((value) {
        if (_equipmentsCt.loadedEquipments.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => const RegisterEquipments(),
          );
        }
        if (_loginCt.userPrefs.tax == 0.0) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Aviso'),
              content: const Text(
                  'Adicione o valor da taxa da sua concessionária de energia na aba de configurações'),
              actions: [
                ElevatedButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }

        _homeStore.appState.value = SuccessAppState();
        setState(() {});
      }).catchError(
        (_) {
          _homeStore.appState.value = FailedAppState(error: 'erro');
          print(_);
          setState(() {});
        },
      );
    } on Exception catch (e) {
      print(e);
      _homeStore.appState.value = FailedAppState(error: e.toString());
    }
  }

  @override
  void dispose() {
    _homeStore.removeListener(() {
      setState(() {});
    });
    _equipmentsCt.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.sizeOf(context).height;
    final List<Widget> widgetOptions = <Widget>[
      HomeNavigationPage(
        equipmentsStore: _equipmentsCt,
        loginController: _loginCt,
      ),
      EquipmentsNavigationPage(
        equipmentsStore: _equipmentsCt,
      ),
      const SavingsNavigationPage(),
    ];

    return SafeArea(
      child: Center(
        child: _homeStore.appState.value is LoadingAppState
            ? const CircularProgressIndicator()
            : _homeStore.appState.value is FailedAppState
                ? const Text('Erro ao carregar, tente novamente.')
                : _homeStore.appState.value is SuccessAppState
                    ? Scaffold(
                        appBar: PreferredSize(
                          preferredSize:
                              Size(MediaQuery.sizeOf(context).width, 90),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserInfoAppBar(user: _loginCt.userConnected),
                                Builder(
                                  builder: (context) => IconButton(
                                    icon: const Icon(Icons.settings_sharp),
                                    onPressed: () =>
                                        Scaffold.of(context).openEndDrawer(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: Container(
                          height: altura,
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              widgetOptions.elementAt(_homeStore.selectedPage),
                              BottomNavigation(
                                homeStore: _homeStore,
                              ),
                            ],
                          ),
                        ),
                        endDrawer: SettingsDrawer(
                          loginCt: _loginCt,
                          equipmentsCt: _equipmentsCt,
                        ),
                        drawerEnableOpenDragGesture: true,
                      )
                    : const SizedBox.shrink(),
      ),
    );
  }
}
