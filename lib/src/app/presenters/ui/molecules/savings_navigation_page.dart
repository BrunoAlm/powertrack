import 'package:flutter/material.dart';

class SavingsNavigationPage extends StatefulWidget {
  const SavingsNavigationPage({super.key});

  @override
  State<SavingsNavigationPage> createState() => _SavingsNavigationPageState();
}

class _SavingsNavigationPageState extends State<SavingsNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Por que instalar um sistema de energia solar?',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
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
              const Text(
                'Existem uma série de programas disponíveis para ajudar a financiar a instalação de um sistema de energia solar, como o Programa de Crédito Fiscal para Energia Renovável (ITC) do governo federal.',
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Obter uma cotação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const ElevatedListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.inverseSurface.withOpacity(.2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
