import 'package:flutter/material.dart';

class EditEquipmentDialog extends StatefulWidget {
  final String name;
  final String power;
  final String time;
  const EditEquipmentDialog({
    super.key,
    required this.name,
    required this.power,
    required this.time,
  });

  @override
  State<EditEquipmentDialog> createState() => _EditEquipmentDialogState();
}

class _EditEquipmentDialogState extends State<EditEquipmentDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isValid = false;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${widget.name}',
            ),
            Text(
              'Potência: ${widget.power}W',
            ),
            Text(
              'Tempo de uso: ${widget.time}h',
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onWillPop: () => Future.value(isValid),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      focusedBorder: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Adicione um nome';
                      }
                      isValid = true;
                      return null;
                    },
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
                    _formKey.currentState!.validate();
                    isValid ? Navigator.pop(context) : () {};
                  },
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    isValid ? Navigator.pop(context) : () {};
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
