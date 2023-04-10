import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/home/store/equipments_store.dart';

class AddedEquipments extends StatefulWidget {
  final EquipmentsStore equipmentsStore;

  const AddedEquipments({
    Key? key,
    required this.equipmentsStore,
  }) : super(key: key);

  @override
  _AddedEquipmentsState createState() => _AddedEquipmentsState();
}

class _AddedEquipmentsState extends State<AddedEquipments> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: ListView.builder(
            itemCount: widget.equipmentsStore.equipments.length,
            itemBuilder: (BuildContext context, int index) {
              var equipment = widget.equipmentsStore.equipments[index];

              return Card(
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
                              equipment.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.equipmentsStore.filteredEquipments.value
                                  .add(equipment.name);
                              widget.equipmentsStore.remove(equipment.id);
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
                                  value: equipment.qty,
                                  onChanged: (value) {
                                    equipment.qty = value!;
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tempo p/ dia'),
                                const SizedBox(height: 18),
                                TextButton(
                                  onPressed: () async {
                                    equipment.time = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 00, minute: 00),
                                      helpText:
                                          'Quantas horas esse equipamento foi utilizado?',
                                      cancelText: 'Cancelar',
                                      confirmText: 'Confirmar',
                                      hourLabelText: 'Horas',
                                      minuteLabelText: 'Minutos',
                                      initialEntryMode:
                                          TimePickerEntryMode.inputOnly,
                                    );
                                    setState(() {});
                                  },
                                  child: Text(
                                    equipment.time?.format(context) ?? '00:00',
                                  ),
                                  style: TextButton.styleFrom(
                                    maximumSize: const Size(100, 50),
                                    padding: const EdgeInsets.all(8),
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
                                        .equipments[index].power,
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
