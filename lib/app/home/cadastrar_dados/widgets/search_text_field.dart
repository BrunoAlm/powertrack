import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, required this.searchController})
      : super(key: key);

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
        suffixIcon: GestureDetector(
          onTap: () => searchController.clear(),
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
