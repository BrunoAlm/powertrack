import 'package:flutter/material.dart';

class HomeStore extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  set changeSelectedPage(int selectedPage) {
    _selectedPage = selectedPage;
    notifyListeners();
  }
}
