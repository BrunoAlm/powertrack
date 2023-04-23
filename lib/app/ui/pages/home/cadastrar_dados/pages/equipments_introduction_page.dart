import 'package:flutter/material.dart';

class EquipmentsIntroduction extends StatelessWidget {
  const EquipmentsIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conhecendo seus gastos:',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Para calcular os custos, é precisamos saber quais são os gastos energético da sua casa.',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                'Preencha os dados com a maior precisão possível.',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
