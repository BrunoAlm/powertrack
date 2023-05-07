import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/pages/dashboard_navigation_page.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/pages/equipments_navigation_page.dart';
import 'package:uitcc/app/ui/pages/home/widgets/bottom_navigation/pages/settings_navigation_page.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';
import 'package:uitcc/app/ui/stores/home_store.dart';
import 'package:uitcc/app/ui/stores/login_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LoginStore _loginStore = Modular.get();
  final EquipmentsStore _equipmentsStore = Modular.get();
  final HomeStore _homeStore = Modular.get();

  @override
  void initState() {
    _equipmentsStore.listDocuments();
    _loginStore.getUserData();
    _homeStore.addListener(() {
      setState(() {});
    });
    _equipmentsStore.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    final List<Widget> _widgetOptions = <Widget>[
      DashboardNavigationpage(equipmentsStore: _equipmentsStore),
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

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Consumo de energia",
      //     style: Theme.of(context).textTheme.titleLarge,
      //   ),
      //   centerTitle: true,
      //   leading: IconButton(
      //     onPressed: () {
      //       _loginStore.getUserData();
      //       Modular.to.pushNamed('profile/');
      //     },
      //     style: IconButton.styleFrom(
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //     ),
      //     icon: Icon(
      //       Icons.person,
      //       color: Theme.of(context).colorScheme.background,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: _altura,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _widgetOptions.elementAt(_homeStore.selectedPage),
                SizedBox(
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BottomNavigation(homeStore: _homeStore),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
