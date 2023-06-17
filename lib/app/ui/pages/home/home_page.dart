import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/controllers/user_prefs_controller.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/pages/dashboard_navigation_page.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/pages/equipments_navigation_page.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/pages/settings_navigation_page.dart';
import 'package:uitcc/app/ui/controllers/equipments_controller.dart';
import 'package:uitcc/app/ui/controllers/home_store.dart';
import 'package:uitcc/app/ui/controllers/login_store.dart';
import 'package:uitcc/app/ui/states/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final LoginStore _loginStore = Modular.get();
  final EquipmentsController _equipmentsStore = Modular.get();
  final UserPrefsController _userPrefs = Modular.get();
  final HomeStore _homeStore = Modular.get();

  @override
  void initState() {
    _homeStore.appState.value = LoadingAppState();
    try {
      _userPrefs.addListener(() {
        setState(() {});
      });
      _homeStore.addListener(() {
        setState(() {});
      });
      _equipmentsStore.addListener(() {
        setState(() {});
      });
      Future.wait([
        _userPrefs.getUserPrefs(),
        _loginStore.getUserData(),
        _equipmentsStore.listDocuments(),
      ]).then((value) {
        _homeStore.appState.value = SuccessAppState();
        setState(() {});
      }).onError((error, stackTrace) {
        _homeStore.appState.value = FailedAppState(error: error.toString());
        setState(() {});
        return null;
      });
    } on Exception catch (e) {
      _homeStore.appState.value = FailedAppState(error: e.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    final List<Widget> widgetOptions = <Widget>[
      DashboardNavigationpage(
        equipmentsStore: _equipmentsStore,
        loginStore: _loginStore,
      ),
      EquipmentsNavigationPage(
        equipmentsStore: _equipmentsStore,
      ),
      const Expanded(
        child: Text(
          'Index 2: Histórico',
        ),
      ),
      SettingsNavigationPage(
        loginStore: _loginStore,
        equipmentsStore: _equipmentsStore,
        userPrefs: _userPrefs,
      ),
    ];

    return SafeArea(
      child: _homeStore.appState.value is LoadingAppState
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _homeStore.appState.value is FailedAppState
              ? const Center(
                  child: Text('Erro ao carregar, tente novamente.'),
                )
              : _homeStore.appState.value is SuccessAppState
                  ? Scaffold(
                      body: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: altura,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                widgetOptions
                                    .elementAt(_homeStore.selectedPage),
                                SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: BottomNavigation(
                                      homeStore: _homeStore,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
    );
  }
}
