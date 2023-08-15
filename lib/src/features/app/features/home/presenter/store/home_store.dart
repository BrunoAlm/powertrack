import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/state/app_state.dart';

class AppStore extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;
  var appState = ValueNotifier<AppState>(PendingAppState());

  set changeSelectedPage(int selectedPage) {
    _selectedPage = selectedPage;
    notifyListeners();
  }
}
