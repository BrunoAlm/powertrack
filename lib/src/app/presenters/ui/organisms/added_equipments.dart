import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/ui/atom/equipments_raw_list.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';

class AddedEquipments extends StatefulWidget {
  final EquipmentsController equipmentsStore;

  const AddedEquipments({
    Key? key,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  AddedEquipmentsState createState() => AddedEquipmentsState();
}

class AddedEquipmentsState extends State<AddedEquipments> {
  @override
  void initState() {
    super.initState();
    // widget.equipmentsStore.equipmentsToBeAdded =
    //     widget.equipmentsStore.loadedEquipments;
    widget.equipmentsStore.searchState.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 350,
        child: ListView.builder(
            itemCount: widget.equipmentsStore.equipmentsToBeAdded.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 18,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.equipmentsStore.equipmentsToBeAdded[index]
                                  .name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // só adiciona se não tiver na lista
                              if (widget.equipmentsStore
                                      .equipmentsToBeAdded[index].name ==
                                  widget.equipmentsStore.loadedEquipments[index]
                                      .name) {
                                widget.equipmentsStore.deleteDocument(widget
                                    .equipmentsStore
                                    .loadedEquipments[index]
                                    .id);
                              }
                              // se não tem na lista de busca, adiciona
                              if (!equipmentsRawList[index].contains(widget
                                  .equipmentsStore
                                  .equipmentsToBeAdded[index]
                                  .name)) {
                                equipmentsRawList.add(widget.equipmentsStore
                                    .equipmentsToBeAdded[index].name);
                              }
                              widget.equipmentsStore.equipmentsToBeAdded
                                  .removeAt(index);

                              widget.equipmentsStore.performSearch();
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text('Quantidade'),
                                DropdownButton<int>(
                                  value: widget.equipmentsStore
                                      .equipmentsToBeAdded[index].qty,
                                  onChanged: (value) {
                                    widget
                                        .equipmentsStore
                                        .equipmentsToBeAdded[index]
                                        .qty = value!;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  underline: const SizedBox(),
                                  menuMaxHeight: 260,
                                  itemHeight: 50,
                                  items: List.generate(
                                    15,
                                    (index) {
                                      return DropdownMenuItem(
                                        value: index + 1,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Tempo p/ dia'),
                                const SizedBox(height: 18),
                                TextButton(
                                  onPressed: () async {
                                    widget
                                        .equipmentsStore
                                        .equipmentsToBeAdded[index]
                                        .time = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 00, minute: 00),
                                      helpText:
                                          'Por quantas horas esse equipamento foi utilizado?',
                                      cancelText: 'Cancelar',
                                      confirmText: 'Confirmar',
                                      hourLabelText: 'Horas',
                                      minuteLabelText: 'Minutos',
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    setState(() {});
                                  },
                                  style: TextButton.styleFrom(
                                    maximumSize: const Size(100, 50),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                  child: Text(
                                    widget.equipmentsStore
                                            .equipmentsToBeAdded[index].time
                                            ?.format(context) ??
                                        '00:00',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Potência'),
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: widget.equipmentsStore
                                        .equipmentsToBeAdded[index].power,
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
            }),
      ),
    );
  }
}
