import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uitcc/src/app/domain/entities/equipment_model.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/equipments_raw_list.dart';
import 'package:uitcc/src/app/presenters/ui/molecules/add_equipment_bottomsheet.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class ResultSearch extends StatelessWidget {
  final EquipmentsController ct;

  const ResultSearch({
    Key? key,
    required this.ct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> filteredEquipmentsName = ct.filteredEquipmentsName.value;
    var logger = Logger();
    return SizedBox(
      height: (65 * filteredEquipmentsName.length.toDouble())
          .clamp(0, 200)
          .toDouble(),
      width: 300,
      child: ListView.builder(
        itemCount: filteredEquipmentsName.length,
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: Theme.of(context).colorScheme.background),
            child: ListTile(
              dense: true,
              title: Text(
                filteredEquipmentsName[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                onPressed: () {
                  ct.searchEC.clear();
                  showDialog(
                    context: context,
                    builder: (context) => AddEquipmentBottomSheet(
                      equip: EquipmentModel(
                        id: Helper.idGenerator(),
                        name: filteredEquipmentsName[index],
                        qty: 1,
                        power: 0,
                        time: DateTime.utc(2023),
                      ),
                      ct: ct,
                    ),
                  ).then((value) {
                    logger.d('log: $value');
                    equipmentsRawList.removeWhere(
                        (element) => element == filteredEquipmentsName[index]);
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
