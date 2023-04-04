import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, required this.searchController}) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar...',
        hintStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.all(8),
        counterText: '',
        suffix: IconButton(
          onPressed: () => searchController.clear(),
          icon: const Icon(Icons.clear),
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
