// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/app/shared/theme/cores.dart';
import 'package:uitcc/app/ui/controllers/home_store.dart';

class BottomNavigation extends StatefulWidget {
  final HomeStore homeStore;
  const BottomNavigation({
    Key? key,
    required this.homeStore,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<BottomNavigationBarItem> navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Dashboard',
      backgroundColor: primary,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.electric_bolt),
      activeIcon: Icon(Icons.electric_bolt),
      label: 'Equipamentos',
      backgroundColor: primary,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.history_outlined),
      activeIcon: Icon(Icons.history),
      label: 'Histórico',
      backgroundColor: primary,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: 'Configurações',
      backgroundColor: primary,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Theme.of(context).hintColor,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedLabelStyle:
          TextStyle(fontSize: 10, color: Theme.of(context).hintColor),
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      enableFeedback: true,
      items: navigationItems,
      currentIndex: widget.homeStore.selectedPage,
      onTap: (value) {
        widget.homeStore.changeSelectedPage = value;
      },
    );
  }
}
