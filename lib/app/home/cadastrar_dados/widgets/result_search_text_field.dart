import 'package:flutter/material.dart';
import 'package:uitcc/app/home/controller/equipamentos_store.dart';

class ResultSearchTextField extends StatefulWidget {
  const ResultSearchTextField(
      {Key? key, required this.filteredData, required this.equipamentosStore})
      : super(key: key);
  final List<String> filteredData;
  final EquipamentosStore equipamentosStore;

  @override
  State<ResultSearchTextField> createState() => _ResultSearchTextFieldState();
}

class _ResultSearchTextFieldState extends State<ResultSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: ListView.builder(
        itemCount: widget.filteredData.length,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) => ListTile(
          title: Text(
            widget.filteredData[index],
            style: const TextStyle(color: Colors.black),
          ),
          trailing: IconButton(
              onPressed: () {
                // TODO: Quando tiver item igual, precisa trocar o icone e remover da lista
                widget.equipamentosStore.adicionar(widget.filteredData[index]);
              },
              icon: const Icon(Icons.add)),
        ),
      ),
    );
  }
}
