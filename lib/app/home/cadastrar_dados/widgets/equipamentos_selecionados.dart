import 'package:flutter/material.dart';
import 'package:uitcc/app/home/controller/equipamentos_store.dart';

class ListViewEquipamentosSelecionados extends StatefulWidget {
  const ListViewEquipamentosSelecionados({
    Key? key,
    required this.equipamentosAdicionados,
  }) : super(key: key);

  final EquipamentosStore equipamentosAdicionados;

  @override
  _ListViewEquipamentosSelecionadosState createState() =>
      _ListViewEquipamentosSelecionadosState();
}

class _ListViewEquipamentosSelecionadosState
    extends State<ListViewEquipamentosSelecionados> {
  int _tempoUsado = 1;
  int _quantidade = 1;
  final potenciaEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: ListView.builder(
            itemCount: widget.equipamentosAdicionados.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.equipamentosAdicionados.value[index],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () => widget.equipamentosAdicionados
                                .remover(widget
                                    .equipamentosAdicionados.value[index]),
                            icon: Icon(
                              Icons.delete_outline,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(width: 0.5),
                            // color: Theme.of(context).colorScheme.background,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Theme.of(context)
                            //         .colorScheme
                            //         .shadow
                            //         .withOpacity(.2),
                            //     offset: const Offset(2, 1),
                            //     blurRadius: 2,
                            //   ),
                            // ],
                            // borderRadius: BorderRadius.circular(10),
                            ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text('Quantidade'),
                                DropdownButton<int>(
                                  value: _quantidade,
                                  onChanged: (value) {
                                    setState(() {
                                      _quantidade = value!;
                                    });
                                  },
                                  underline: const SizedBox(),
                                  menuMaxHeight: 260,
                                  itemHeight: 50,
                                  items: List.generate(5, (index) {
                                    return DropdownMenuItem(
                                      value: index + 1,
                                      child: Text(
                                        (index + 1).toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Tempo p/ dia'),
                                DropdownButton<int>(
                                  value: _tempoUsado,
                                  onChanged: (value) {
                                    setState(() {
                                      _tempoUsado = value!;
                                    });
                                  },
                                  alignment: Alignment.center,
                                  underline: const SizedBox(),
                                  menuMaxHeight: 260,
                                  itemHeight: 50,
                                  items: List.generate(24, (index) {
                                    return DropdownMenuItem(
                                      value: index + 1,
                                      child: Text(
                                        '${index + 1}hr',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Potência'),
                                SizedBox(
                                  width: 65,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    decoration: InputDecoration(
                                      hintText: 'kWh',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5),
                                      border: const UnderlineInputBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // Padding(
              //     padding: const EdgeInsets.only(bottom: 8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         SizedBox(
              //           width: 125,
              //           child: Text(
              //             widget.equipamentosAdicionados.value[index],
              //             style: Theme.of(context).textTheme.labelSmall,
              //           ),
              //         ),
              //         const SizedBox(width: 10),
              //         SizedBox(
              //           width: 35,
              //           child: DropdownButton<int>(
              //             value: _quantidade,
              //             onChanged: (value) {
              //               setState(() {
              //                 _quantidade = value!;
              //               });
              //             },
              //             menuMaxHeight: 260,
              //             itemHeight: 50,
              //             items: List.generate(5, (index) {
              //               return DropdownMenuItem(
              //                 value: index + 1,
              //                 child: Text(
              //                   (index + 1).toString(),
              //                   style: Theme.of(context).textTheme.labelSmall,
              //                 ),
              //               );
              //             }),
              //           ),
              //         ),
              //         const SizedBox(width: 10),
              //         SizedBox(
              //           width: 50,
              //           child: DropdownButton<int>(
              //             value: _tempoUsado,
              //             onChanged: (value) {
              //               setState(() {
              //                 _tempoUsado = value!;
              //               });
              //             },
              //             menuMaxHeight: 260,
              //             itemHeight: 50,
              //             items: List.generate(24, (index) {
              //               return DropdownMenuItem(
              //                 value: index + 1,
              //                 child: Text(
              //                   '${index + 1}hr',
              //                   style: Theme.of(context).textTheme.labelSmall,
              //                 ),
              //               );
              //             }),
              //           ),
              //         ),
              //         const SizedBox(width: 10),
              //         SizedBox(
              //           width: 60,
              //           child: Text(
              //             '1234 kWh',
              //             style: Theme.of(context).textTheme.labelSmall,
              //           ),
              //         ),
              //       ],
              //     ));
            }),
      ),
    );
  }
}
