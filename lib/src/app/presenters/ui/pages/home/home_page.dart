import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/bottom_navigation.dart';
import 'package:uitcc/src/app/presenters/ui/pages/home/molecules/dashboard_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/pages/home/molecules/equipments_navigation_page.dart';
import 'package:uitcc/src/app/presenters/ui/pages/home/molecules/settings_navigation_page.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/home_store.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/app/presenters/ui/states/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final LoginController _loginStore = Modular.get();
  final EquipmentsController _equipmentsStore = Modular.get();
  final HomeStore _homeStore = Modular.get();

  @override
  void initState() {
    super.initState();

    _homeStore.appState.value = LoadingAppState();
    try {
      _homeStore.addListener(() {
        setState(() {});
      });
      _equipmentsStore.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
      Future.wait([
        _loginStore.initUser(),
        _equipmentsStore.listDocuments(),
      ]).then((value) {
        _homeStore.appState.value = SuccessAppState();
        setState(() {});
      }).catchError((error) {
        _homeStore.appState.value = FailedAppState(error: error.toString());
        print(error.toString());
        setState(() {});
      });
    } on Exception catch (e) {
      _homeStore.appState.value = FailedAppState(error: e.toString());
    }
  }

  @override
  void dispose() {
    _homeStore.removeListener(() {
      setState(() {});
    });
    _equipmentsStore.removeListener(() {
      setState(() {});
    });
    super.dispose();
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
                        child: SizedBox(
                          height: altura,
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
                      ),
                    )
                  : const SizedBox(),
    );
  }
}
