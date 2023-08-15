import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class RemoveDataDialog extends StatelessWidget {
  final EquipmentsController equipmentsCt;
  const RemoveDataDialog({super.key, required this.equipmentsCt});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remover dados'),
      content: RichText(
        text: TextSpan(
          text: 'Ao clicar em confirmar, você vai ',
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'remover',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            TextSpan(
              text: ' seus equipamentos cadastrados',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
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
              equipmentsCt.deleteAllDocuments();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text(
              'Confirmar',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
