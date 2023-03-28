import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResultDialog extends StatelessWidget {
  final double leituraAtual;
  final double leituraAnterior;
  final double valorDoKwh;
  final int periodo;
  final double valorAPagar;

  const ResultDialog({
    Key? key,
    required this.leituraAtual,
    required this.leituraAnterior,
    required this.valorDoKwh,
    required this.periodo,
    required this.valorAPagar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      title: const Text('Resultado'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
           leituraAtual,
           leituraAnterior,
           periodo,
           valorDoKwh,
           */
          const Text('Entrada:'),
          Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Leitura atual: $leituraAtual"),
                  const SizedBox(height: 10),
                  Text("Leitura anterior: $leituraAnterior"),
                  const SizedBox(height: 10),
                  Text("Valor do kWh: $valorDoKwh"),
                ],
              ),
            ),
          ),
          Center(child: Text("Valor a pagar: $valorAPagar")),
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
