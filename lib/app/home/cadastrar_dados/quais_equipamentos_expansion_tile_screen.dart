import 'package:flutter/material.dart';
import 'package:uitcc/app/home/cadastrar_dados/equipamentos.dart';

class QuaisEquipamentosExpansionTileScreen extends StatefulWidget {
  const QuaisEquipamentosExpansionTileScreen({super.key});

  @override
  State<QuaisEquipamentosExpansionTileScreen> createState() =>
      QuaisEquipamentosExpansionTileScreenState();
}

class QuaisEquipamentosExpansionTileScreenState
    extends State<QuaisEquipamentosExpansionTileScreen> {
  bool isChecked = false;
  // final int _quantidade = 0;
  final qtdEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 700,
            child: ListView.builder(
              itemCount: equipamentos.length,
              itemBuilder: (context, index) => ExpansionTile(
                title: Text(equipamentos[index]),
                children: [
                  Row(
                    children: const [
                      Text('Quantidade'),
                      DropdownButtonExample(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> list = <String>['1', '2', '3', '4'];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (int? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: List.generate(5, (index) {
        return DropdownMenuItem(
          value: index + 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text((index + 1).toString()),
          ),
        );
      }),
    );
  }
}
