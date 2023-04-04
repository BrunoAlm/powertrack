import 'package:flutter/material.dart';
import 'package:uitcc/app/home/controller/equipamentos_store.dart';

class ListViewEquipamentosSelecionados extends StatefulWidget {
  const ListViewEquipamentosSelecionados(
      {Key? key, required this.equipamentosAdicionados})
      : super(key: key);
  final EquipamentosStore equipamentosAdicionados;

  @override
  _ListViewEquipamentosSelecionadosState createState() =>
      _ListViewEquipamentosSelecionadosState();
}

class _ListViewEquipamentosSelecionadosState
    extends State<ListViewEquipamentosSelecionados> {
  int _tempoUsado = 1;
  int _quantidade = 1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.equipamentosAdicionados.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 125,
                      child: Text(
                        widget.equipamentosAdicionados.value[index],
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 35,
                      child: DropdownButton<int>(
                        value: _quantidade,
                        onChanged: (value) {
                          setState(() {
                            _quantidade = value!;
                          });
                        },
                        menuMaxHeight: 260,
                        itemHeight: 50,
                        items: List.generate(5, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(
                              (index + 1).toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: DropdownButton<int>(
                        value: _tempoUsado,
                        onChanged: (value) {
                          setState(() {
                            _tempoUsado = value!;
                          });
                        },
                        menuMaxHeight: 260,
                        itemHeight: 50,
                        items: List.generate(24, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(
                              '${index + 1}hr',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 60,
                      child: Text(
                        '1234 kWh',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
