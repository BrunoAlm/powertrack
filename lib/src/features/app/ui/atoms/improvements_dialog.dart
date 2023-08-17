import 'package:flutter/material.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class ImprovementsDialog extends StatelessWidget {
  const ImprovementsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Melhorias previstas',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Melhorias pensadas para versões futuras:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 15),
          RichText(
            text: TextSpan(
              text: '1. ',
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Integração de dispositivos IOT: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                TextSpan(
                  text:
                      'Coleta de consumo (kWh) e tempo de uso em tempo real ou diário.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '2. ',
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Adição de gráficos: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                TextSpan(
                  text: 'Gráficos para facilitar a visualização dos dados',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            shadows: ThemeHelper.shadow(context),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text(
              'Ok',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
