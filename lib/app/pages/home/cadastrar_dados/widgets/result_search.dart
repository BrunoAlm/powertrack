// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uitcc/app/pages/home/store/equipments_store.dart';

class ResultSearch extends StatefulWidget {
  final EquipmentsStore equipmentStore;
  const ResultSearch({
    Key? key,
    required this.equipmentStore,
  }) : super(key: key);

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: ListView.builder(
        itemCount: widget.equipmentStore.filteredEquipments.value.length,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              widget.equipmentStore.filteredEquipments.value[index],
              style: const TextStyle(color: Colors.black),
            ),
            trailing: IconButton(
                onPressed: () {
                  widget.equipmentStore.add(
                    name: widget.equipmentStore.filteredEquipments.value[index],
                    qty: 1,
                    time: const TimeOfDay(hour: 00, minute: 00),
                    power: TextEditingController(),
                  );
                  widget.equipmentStore.removeIfExist(index: index);
                },
                icon: const Icon(Icons.add)),
          );
        },
      ),
    );
  }
}
