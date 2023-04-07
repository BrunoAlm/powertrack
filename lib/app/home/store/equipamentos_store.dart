import 'package:flutter/material.dart';
import 'package:uitcc/app/home/cadastrar_dados/api/equipment_model/equipment.dart';

class EquipamentosStore extends ValueNotifier<List<String>> {
  EquipamentosStore() : super([]);
  // Equipment equipment = Equipment(name: '', qty: 0, timeSpent: '', power: 0);
 
  void adicionar(String equipamentoEscolhido) {
    value.add(equipamentoEscolhido);

    notifyListeners();
  }

  void remover(String equipamentoEscolhido) {
    value.remove(equipamentoEscolhido);
    notifyListeners();
  }
}
