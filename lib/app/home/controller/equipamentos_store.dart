import 'package:flutter/material.dart';

class EquipamentosStore extends ValueNotifier<List<String>> {
  EquipamentosStore() : super([]);

  void adicionar(String equipamentoEscolhido) {
    value.add(equipamentoEscolhido);
    notifyListeners();
  }
}
