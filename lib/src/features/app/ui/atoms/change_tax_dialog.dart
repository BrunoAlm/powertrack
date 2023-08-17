import 'package:flutter/material.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class ChangeTaxDialog extends StatefulWidget {
  final LoginController loginCt;

  const ChangeTaxDialog({
    super.key,
    required this.loginCt,
  });

  @override
  State<ChangeTaxDialog> createState() => _ChangeTaxDialogState();
}

class _ChangeTaxDialogState extends State<ChangeTaxDialog> {
  final TextEditingController taxEC = TextEditingController();

  @override
  void dispose() {
    taxEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    taxEC.text = widget.loginCt.userPrefs.tax.toString();
    return AlertDialog(
      title: const Text('Alterar taxa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'A taxa é o valor que a sua distribuidora de energia cobra por kWh consumido.',
          ),
          const SizedBox(height: 20),
          TextField(
            controller: taxEC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Insira o valor',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(Icons.receipt),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22))),
            shadows: ThemeHelper.shadow(context),
          ),
          child: ElevatedButton(
            onPressed: () {
              String taxToAdd = taxEC.text.replaceAll(',', '.');
              double? taxValue = double.tryParse(taxToAdd);
              if (taxValue != null && taxValue >= 0.0 && taxValue <= 20.0) {
                widget.loginCt.updateTax(taxValue);
                Navigator.pop(context);
              } else {
                String errorMessage =
                    'A taxa deve ser um número entre 0.0 e 20.0.';
                if (taxValue != null && (taxValue < 0.0 || taxValue > 20.0)) {
                  errorMessage = 'A taxa deve estar entre 0.0 e 20.0.';
                }
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Taxa inválida'),
                    content: Text(errorMessage),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                        ),
                        child: Text(
                          'OK',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text(
              'Alterar',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
