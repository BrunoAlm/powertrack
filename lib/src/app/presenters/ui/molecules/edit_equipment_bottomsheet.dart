import 'package:flutter/material.dart';
import 'package:uitcc/src/app/domain/entities/equipment_model.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';

class EditEquipmentBottomSheet extends StatefulWidget {
  final EquipmentModel equipmentModel;
  final EquipmentsController ct;
  // final String name;
  // final String power;
  // final String time;
  // final int qty;
  const EditEquipmentBottomSheet({
    super.key,
    required this.equipmentModel,
    required this.ct,
    // required this.name,
    // required this.power,
    // required this.time,
    // required this.qty,
  });

  @override
  State<EditEquipmentBottomSheet> createState() =>
      _EditEquipmentBottomSheetState();
}

class _EditEquipmentBottomSheetState extends State<EditEquipmentBottomSheet> {
  EquipmentModel get equipment => widget.equipmentModel;
  final _formKey = GlobalKey<FormState>();
  late EquipmentModel newEquipment;

  @override
  void initState() {
    newEquipment = equipment;
    super.initState();
  }

  @override
  void dispose() {
    newEquipment;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: BottomSheet(
        onClosing: () => _formKey.currentState!.validate(),
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
              const SizedBox(
                height: 18,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onWillPop: () =>
                    Future.value(_formKey.currentState!.validate()),
                child: Column(
                  children: [
                    BottomSheetTextField(
                      data: equipment.name,
                      icon: Icons.text_fields_rounded,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: BottomSheetTextField(
                            data: equipment.power.text,
                            icon: Icons.power_input_rounded,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              side: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: DropdownButton<int>(
                            value: equipment.qty,
                            onChanged: (value) {
                              newEquipment.qty = value!;
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
                    const SizedBox(height: 8),
                    BottomSheetTextField(
                      data: equipment.time!.format(context),
                      icon: Icons.access_time_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.validate()
                          ? Navigator.pop(context)
                          : () {};
                    },
                    child: const Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate()
                          ? () {
                              Navigator.pop(context);
                              widget.ct.updateDocument(
                                equipment: newEquipment,
                                documentId: newEquipment.id,
                              );
                            }
                          : () {};
                    },
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetTextField extends StatelessWidget {
  final String data;
  final IconData icon;
  const BottomSheetTextField({
    super.key,
    required this.data,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: TextFormField(
        initialValue: data,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Adicione um valor';
          }
          return null;
        },
      ),
    );
  }
}
