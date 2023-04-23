// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';

class SearchTextField extends StatefulWidget {
  final EquipmentsStore equipmentsStore;
  const SearchTextField({
    Key? key,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  void initState() {
    widget.equipmentsStore.searchEC.addListener(() {
      widget.equipmentsStore.performSearch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.equipmentsStore.searchEC,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar...',
        hintStyle: const TextStyle(color: Colors.black54),
        suffixIcon: GestureDetector(
          onTap: () => widget.equipmentsStore.searchEC.clear(),
          child: const Icon(Icons.clear),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
