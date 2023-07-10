import 'package:flutter/material.dart';

class SavingsNavigationPage extends StatefulWidget {
  const SavingsNavigationPage({super.key});

  @override
  State<SavingsNavigationPage> createState() => _SavingsNavigationPageState();
}

class _SavingsNavigationPageState extends State<SavingsNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          Text('Voce vai economizar tantos se fizer isso, isso e mais isso'),
        ],
      ),
    );
  }
}
