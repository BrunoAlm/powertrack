import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/savings/ui/atoms/elevated_list_tile.dart';

class SavingsNavigation extends StatefulWidget {
  final EquipmentsController equipCt;
  const SavingsNavigation({super.key, required this.equipCt});

  @override
  State<SavingsNavigation> createState() => _SavingsNavigationState();
}

class _SavingsNavigationState extends State<SavingsNavigation> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Por que instalar um sistema de energia solar?',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18.0),

              const ElevatedListTile(
                title: 'Economizar dinheiro',
                subtitle:
                    'Os sistemas de energia solar podem ajudá-lo a economizar dinheiro na sua conta de luz.',
              ),
              const SizedBox(height: 10),
              const ElevatedListTile(
                title: 'Reduzir sua pegada de carbono',
                subtitle:
                    'Os sistemas de energia solar não produzem emissões de carbono, o que pode ajudá-lo a reduzir o seu impacto ambiental.',
              ),
              const SizedBox(height: 10),
              const ElevatedListTile(
                title: 'Tornar sua casa mais independente da rede elétrica',
                subtitle:
                    'Os sistemas de energia solar podem ajudá-lo a tornar sua casa mais independente da rede elétrica, o que pode torná-la mais resiliente a apagões.',
              ),
              const SizedBox(height: 16.0),
              const ElevatedListTile(
                title: 'Quanto custa instalar um sistema de energia solar?',
                subtitle:
                    'O custo de instalação de um sistema de energia solar varia de acordo com uma série de fatores, como o tamanho do sistema, o tipo de painel e a localização da sua casa. No entanto, os sistemas de energia solar estão se tornando cada vez mais acessíveis.',
              ),
              const SizedBox(height: 16.0),
              const ElevatedListTile(
                title: 'Financiamento na instalação',
                subtitle:
                    'Existem uma série de programas disponíveis para ajudar a financiar a instalação de um sistema de energia solar, como o Programa de Crédito Fiscal para Energia Renovável (ITC) do governo federal.',
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
