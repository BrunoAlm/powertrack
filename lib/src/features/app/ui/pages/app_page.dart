import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';
import 'package:uitcc/src/features/app/features/savings/ui/page/savings_navigation.dart';
import 'package:uitcc/src/features/app/ui/molecules/user_info_appbar.dart';
import 'package:uitcc/src/features/app/ui/molecules/bottom_navigation.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/page/equipments_navigation.dart';
import 'package:uitcc/src/features/app/features/home/presenter/ui/page/home_page.dart';
import 'package:uitcc/src/features/app/ui/molecules/settings_drawer.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/home/presenter/store/home_store.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/features/app/state/app_state.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/page/add_equipments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final LoginController _loginCt = Modular.get();
  final EquipmentsController _equipmentsCt = Modular.get();
  final AppStore _appStore = Modular.get();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _appStore.appState.value = LoadingAppState();

    _appStore.appState.addListener(() {
      final appState = _appStore.appState.value;

      switch (appState) {
        case FailedAppState():
          Helper.appwriteErrorDialog(
            message: appState.message,
            code: appState.code,
            context: context,
          );
          break;
        // case SuccessAppState():
        //   if (_loginCt.userPrefs.tax == 0.0) {
        //     showDialog(
        //       context: context,
        //       builder: (context) {
        //         return const SimpleDialog(
        //           title: Text('data'),
        //         );
        //       },
        //     );
        //   }
        //   break;
      }
    });

    _appStore.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _equipmentsCt.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _loginCt.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    Future.wait([
      _loginCt.initUser(),
      _equipmentsCt.listDocuments(),
    ]).then((value) {
      var tax = _loginCt.userPrefs.tax;
      var theme = _loginCt.userPrefs.theme;
      logger.i('UserPrefs \ntax $tax \ntheme $theme');
      if (_equipmentsCt.loadedEquipments.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AddEquipmentsPage(
            equipmentCt: _equipmentsCt,
          ),
        );
      }
      if (_equipmentsCt.loadedEquipments.isNotEmpty &&
          _loginCt.userPrefs.tax == 0.0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Aviso'),
            content: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'É preciso alterar a taxa para poder calcular os valores.',
                ),
                SizedBox(height: 10),
                Text(
                  'A taxa é o valor que a sua distribuidora de energia cobra por kWh consumido.',
                ),
                SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text('Você pode alterar clicando no ícone'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.settings),
                    ),
                    Text('e depois em "Alterar taxa"'),
                  ],
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Modular.to.pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      _appStore.appState.value = SuccessAppState();
      if (mounted) {
        setState(() {});
      }
    }).catchError(
      (e) {
        // throw e;
        _appStore.appState.value = FailedAppState(message: e, code: 0);

        // print('Erro no catch -> $e');
        // print('aqui');

        // if (mounted) {
        //   setState(() {});
        // }
      },
    );
  }

  @override
  void dispose() {
    _appStore.dispose();
    _equipmentsCt.dispose();
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
      EquipmentsNavigation(
        equipmentsCt: _equipmentsCt,
      ),
      SavingsNavigation(equipCt: _equipmentsCt),
      // GanttChart(equipmentsList: _equipmentsCt.loadedEquipments)
    ];

    return SafeArea(
      child: Center(
          child: AnimatedBuilder(
              animation: _appStore.appState,
              builder: (context, widget) {
                return _appStore.appState.value is LoadingAppState
                    ? const CircularProgressIndicator()
                    : _appStore.appState.value is FailedAppState
                        ? const Scaffold(
                            body: Center(
                              child: Text('Erro ao carregar'),
                            ),
                          )
                        : Scaffold(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            appBar: PreferredSize(
                              preferredSize:
                                  Size(MediaQuery.sizeOf(context).width, 90),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 30, 20, 0),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 800,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        UserInfoAppBar(
                                            user: _loginCt.userConnected),
                                        Builder(
                                          builder: (context) => IconButton(
                                            icon: const Icon(Icons.settings,
                                                size: 29),
                                            onPressed: () =>
                                                Scaffold.of(context)
                                                    .openEndDrawer(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            body: Container(
                              height: altura - 90,
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  widgetOptions
                                      .elementAt(_appStore.selectedPage),
                                  BottomNavigation(
                                    homeStore: _appStore,
                                  ),
                                ],
                              ),
                            ),
                            endDrawer: SettingsDrawer(
                              homeStore: _appStore,
                              loginCt: _loginCt,
                              equipmentsCt: _equipmentsCt,
                            ),
                            onEndDrawerChanged: (isOpened) {
                              if (!isOpened) {
                                setState(() {});
                              }
                            },
                            drawerEnableOpenDragGesture: true,
                          );
              })),
    );
  }
}
