import 'package:flutter/material.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class ChangeTaxDialog extends StatelessWidget {
  final LoginController loginCt;
  final TextEditingController taxEC = TextEditingController();

  ChangeTaxDialog({
    super.key,
    required this.loginCt,
  });

  @override
  Widget build(BuildContext context) {
    taxEC.text = loginCt.userPrefs.tax.toString();
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
              double? taxValue =
                  double.tryParse(taxEC.text.replaceAll(',', '.'));
              if (taxValue != null) {
                loginCt.updateTax(taxValue);
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('coloque um valor válido'),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
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
