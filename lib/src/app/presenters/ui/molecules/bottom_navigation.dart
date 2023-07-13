// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/home_store.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

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
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.electric_bolt),
      activeIcon: Icon(Icons.electric_bolt),
      label: 'Equipamentos',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.energy_savings_leaf_outlined),
      activeIcon: Icon(Icons.energy_savings_leaf_rounded),
      label: 'Economia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: ThemeHelper.shadow(context),
      ),
      child: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(.3),
        selectedItemColor: Theme.of(context).colorScheme.onBackground,
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        showUnselectedLabels: false,
        useLegacyColorScheme: false,
        enableFeedback: true,
        items: navigationItems,
        currentIndex: widget.homeStore.selectedPage,
        onTap: (value) {
          widget.homeStore.changeSelectedPage = value;
        },
      ),
    );
  }
}
