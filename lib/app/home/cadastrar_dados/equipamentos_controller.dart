import 'package:flutter/material.dart';

class PesquisaEquipamentosController extends ValueNotifier<List<String>> {
  PesquisaEquipamentosController(super.value);
  List<String> listaFiltrada = [];

  busca(List<String> _lista, TextEditingController _controller) {
    listaFiltrada = _lista
        .where((element) =>
            element.toLowerCase().contains(_controller.text.toLowerCase()))
        .toList();
  }
}