import 'package:flutter/material.dart';
import 'package:uitcc/src/app/domain/entities/equipment_model.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/ui/atom/bottom_sheet_text_field.dart';
import 'package:uitcc/src/app/presenters/ui/atom/time_picker.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class EditEquipmentBottomSheet extends StatefulWidget {
  final EquipmentModel equip;
  final EquipmentsController ct;
  const EditEquipmentBottomSheet({
    Key? key,
    required this.equip,
    required this.ct,
  }) : super(key: key);

  @override
  State<EditEquipmentBottomSheet> createState() =>
      _EditEquipmentBottomSheetState();
}

class _EditEquipmentBottomSheetState extends State<EditEquipmentBottomSheet> {
  EquipmentModel get equipment => widget.equip;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nNameEC = TextEditingController();
  final TextEditingController nPowerEC = TextEditingController();

  @override
  void dispose() {
    nNameEC;
    nPowerEC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nNameEC.text = equipment.name;
    nPowerEC.text = equipment.power.toString();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onWillPop: () => Future.value(_formKey.currentState!.validate()),
        child: BottomSheet(
          onClosing: () {
            _formKey.currentState!.validate();
            widget.ct.performSearch();
          },
          builder: (context) => Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Editar equipamento',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    BottomSheetTextField(
                      textController: nNameEC,
                      data: equipment.name,
                      icon: Icons.text_fields_rounded,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: BottomSheetTextField(
                            textController: nPowerEC,
                            data: equipment.power.toString(),
                            icon: Icons.power_input_rounded,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              side: BorderSide(width: 2),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: DropdownButton<int>(
                            value: equipment.qty,
                            onChanged: (value) {
                              equipment.qty = value!;
                              setState(() {});
                            },
                            underline: const SizedBox(),
                            menuMaxHeight: 260,
                            items: List.generate(
                              10,
                              (index) {
                                return DropdownMenuItem(
                                  value: index + 1,
                                  child: Text(
                                    (index + 1).toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: ThemeHelper.shadow(context),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tempo de uso (mês)',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text('horas / dia',
                              style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .5,
                            child: TimePicker(equiModel: equipment),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        color: Theme.of(context).colorScheme.background,
                        shadows: ThemeHelper.shadow(context),
                      ),
                      child: IconButton(
                          onPressed: () {
                            widget.ct.deleteDocument(equipment.id);

                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Voltar',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        elevation: 3,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if ((equipment.time.hour == 0) &&
                              (equipment.time.minute == 0)) {
                          } else {
                            equipment.name = nNameEC.text;
                            equipment.power = int.parse(nPowerEC.text);

                            widget.ct.updateDocument(equipment: equipment);

                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(
                        'Confirmar',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
