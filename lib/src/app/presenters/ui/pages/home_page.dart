// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/ui/atom/user_info_appbar.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/bottom_navigation.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/equipments_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/home_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/savings_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/settings_drawer.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/home_store.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/presenters/ui/states/app_state.dart';
import 'package:uitcc/src/app/presenters/ui/organisms/register_equipments_page.dart';

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
        if (mounted) {
          setState(() {});
        }
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
        print(_loginCt.userPrefs.tax);
        print(_loginCt.userPrefs.theme);
        if (_equipmentsCt.loadedEquipments.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => RegisterEquipmentsPage(
              equipmentCt: _equipmentsCt,
            ),
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
        if (mounted) {
          setState(() {});
        }
      }).catchError(
        (_) {
          _homeStore.appState.value = FailedAppState(error: 'erro');
          print(_);
          print('aqui');

          if (mounted) {
            setState(() {});
          }
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
        equipmentsCt: _equipmentsCt,
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
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
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
                                    icon: const Icon(Icons.settings, size: 29),
                                    onPressed: () =>
                                        Scaffold.of(context).openEndDrawer(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: Container(
                          height: altura - 90,
                          margin: const EdgeInsets.only(top: 20),
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
                          homeStore: _homeStore,
                          loginCt: _loginCt,
                          equipmentsCt: _equipmentsCt,
                        ),
                        onEndDrawerChanged: (isOpened) {
                          if (!isOpened) {
                            setState(() {});
                          }
                        },
                        drawerEnableOpenDragGesture: true,
                      )
                    : const SizedBox.shrink(),
      ),
    );
  }
}
