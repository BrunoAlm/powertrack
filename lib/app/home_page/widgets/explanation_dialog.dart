import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExplanationDialog extends StatelessWidget {
  const ExplanationDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      title: const Text('Como funciona?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Para o cálculo é necessário as seguintes informações:"),
          SizedBox(height: 10),
          Text("1. A leitura atual do medidor de energia."),
          SizedBox(height: 10),
          Text("2. A leitura anterior do medidor de energia."),
          SizedBox(height: 10),
          Text("3. O valor do kWh determinado pela distribuidora de energia."),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Modular.to.pop,
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
