import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/domain/entity/equipment_model.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/bottom_sheet_text_field.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/qty_dropdown.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/ui/atom/time_picker.dart';
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
                        hintText: 'Nome do equipamento',
                        icon: Icons.text_fields_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: BottomSheetTextField(
                              textController: nPowerEC,
                              hintText: 'Potência do equipamento (W)',
                              icon: Icons.power_input_rounded,
                              inputType: TextInputType.number,
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
                          QtyDropdown(equipment: equipment),
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
      ),
    );
  }
}
