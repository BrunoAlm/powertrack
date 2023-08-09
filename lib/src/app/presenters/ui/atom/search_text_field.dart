import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';

class SearchTextField extends StatefulWidget {
  final EquipmentsController equipmentsStore;
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
      autofocus: true,
      
      decoration: InputDecoration(
        hintText: 'Buscar...',
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        suffixIcon: GestureDetector(
          onTap: () => widget.equipmentsStore.searchEC.clear(),
          child: const Icon(Icons.clear),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
