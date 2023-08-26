import 'package:flutter/material.dart';
import 'package:uitcc/src/core/data/equipments_raw_list.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/bottom_sheet_text_field.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/qty_dropdown.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/time_picker.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class AddEquipmentBottomSheet extends StatefulWidget {
  final EquipmentModel equip;
  final EquipmentsController ct;
  const AddEquipmentBottomSheet({
    Key? key,
    required this.equip,
    required this.ct,
  }) : super(key: key);

  @override
  State<AddEquipmentBottomSheet> createState() =>
      _AddEquipmentBottomSheetState();
}

class _AddEquipmentBottomSheetState extends State<AddEquipmentBottomSheet> {
  EquipmentModel get equipment => widget.equip;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nNameEC = TextEditingController();
  final TextEditingController nPowerEC = TextEditingController();

  @override
  void initState() {
    nNameEC.text = equipment.name;
    nPowerEC.text = equipment.power.toString();
    super.initState();
  }

  @override
  void dispose() {
    nNameEC;
    nPowerEC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: BottomSheet(
          enableDrag: false,
          onClosing: () {
            _formKey.currentState!.validate();
            widget.ct.performSearch();
          },
          builder: (context) => Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Novo equipamento',
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
                        labelText: 'Nome',
                        icon: Icons.text_fields_rounded,
                        inputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          if (value.length >= 30) {
                            return 'Não pode ser maior que 30 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: BottomSheetTextField(
                              textController: nPowerEC,
                              labelText: 'Potência (W)',
                              inputType: TextInputType.number,
                              inputAction: TextInputAction.next,
                              icon: Icons.power_input_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }

                                int? parsedValue = int.tryParse(value);

                                if (parsedValue == null) {
                                  return 'Valor inválido';
                                }

                                if (parsedValue == 0) {
                                  return 'Não pode ser 0';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: QtyDropdown(equipment: equipment)),
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
                              'Tempo de uso por mês',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
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
                              widget.ct.equipmentsToBeAdded.removeWhere(
                                  (element) => element.id == equipment.id);
                              widget.ct.performSearch();
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
                              bool equipmentExists = false;
                              equipment.name = nNameEC.text;
                              equipment.power = int.parse(nPowerEC.text);

                              for (var i = 0;
                                  i < widget.ct.equipmentsToBeAdded.length;
                                  i++) {
                                if (widget.ct.equipmentsToBeAdded[i].id ==
                                    equipment.id) {
                                  widget.ct.equipmentsToBeAdded[i] = equipment;
                                  equipmentExists = true;
                                  break;
                                }
                              }

                              if (!equipmentExists) {
                                widget.ct.equipmentsToBeAdded.add(equipment);
                              }
                              equipmentsRawList.removeWhere(
                                  (element) => element == equipment.name);

                              widget.ct.performSearch();
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
      ),
    );
  }
}
