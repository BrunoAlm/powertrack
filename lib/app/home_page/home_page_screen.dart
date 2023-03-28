import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/widgets/custom_text_form_field.dart';
import 'widgets/explanation_dialog.dart';
import 'widgets/result_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () => showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) => const ExplanationDialog(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados para o cálculo",
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Modular.to.pushNamed('profile/'),
          style: IconButton.styleFrom(
              side: const BorderSide(color: Colors.black, width: 1)),
          icon: const Icon(Icons.person),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const LeituraDeEnergia(),
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed('cadastrar_dados'),
              child: const Text('Cadastrar dados'),
            )
          ],
        ),
      ),
    );
  }
}

// LEITURA DE ENERGIA
class LeituraDeEnergia extends StatefulWidget {
  const LeituraDeEnergia({Key? key}) : super(key: key);

  @override
  State<LeituraDeEnergia> createState() => _LeituraDeEnergiaState();
}

class _LeituraDeEnergiaState extends State<LeituraDeEnergia> {
  final kwAtualEC = TextEditingController();
  final kwAnteriorEC = TextEditingController();
  final kwValorEC = TextEditingController();
  static const int periodo = 30;
  bool camposCorretos = false;
  double valorAPagar = 0.0;

  double _calculaConsumo(
    double leituraAtual,
    double leituraAnterior,
    int diasDoPeriodo,
    double valorDoKwh,
  ) {
    // cálculo do consumo em kWh
    double consumo = leituraAtual - leituraAnterior;
    // print('Consumo: $consumo kWh');

    // cálculo do consumo diário em kWh
    double consumoDiario = consumo / diasDoPeriodo;
    // print('Consumo diário: $consumoDiario kWh');

    // cálculo do consumo mensal em kWh
    double consumoMensal = consumoDiario * 30; // considerando um mês de 30 dias
    // print('Consumo mensal: $consumoMensal kWh');

    // cálculo do valor a ser pago na conta de energia elétrica
    double valorAPagar = consumoMensal * valorDoKwh;
    // print('Valor a pagar: R\$ $valorAPagar');
    return valorAPagar;
  }

  @override
  void dispose() {
    kwAtualEC;
    kwAnteriorEC;
    kwValorEC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Leitura de energia",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: 'Atual KW/h',
              maxWidth: 120.0,
              controller: kwAtualEC,
            ),
            const SizedBox(width: 10),
            CustomTextFormField(
              hintText: 'Anterior KW/h',
              maxWidth: 140.0,
              controller: kwAnteriorEC,
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          hintText: 'Valor por KW/h',
          maxWidth: 160.0,
          controller: kwValorEC,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            double leituraAtual = 0.0;
            double leituraAnterior = 0.0;
            double valorDoKwh = 0.0;
            try {
              leituraAtual = double.parse(kwAtualEC.value.text);
              leituraAnterior = double.parse(kwAnteriorEC.value.text);
              valorDoKwh = double.parse(kwValorEC.value.text);
              camposCorretos = true;
              // print(camposCorretos);
            } catch (e) {
              // print('Preencha os campos');
            }

            if (camposCorretos) {
              setState(() {});
              valorAPagar = _calculaConsumo(
                leituraAtual,
                leituraAnterior,
                periodo,
                valorDoKwh,
              );
              showDialog(
                context: context,
                builder: (context) => ResultDialog(
                  leituraAtual: leituraAtual,
                  leituraAnterior: leituraAnterior,
                  valorDoKwh: valorDoKwh,
                  periodo: periodo,
                  valorAPagar: valorAPagar,
                ),
              );
            }
          },
          child: const Text("Calcular"),
        ),
        const SizedBox(height: 40),
        camposCorretos
            ? Center(
                child: Text(
                  'Valor a pagar: $valorAPagar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            : const SizedBox(height: 40),
      ],
    );
  }
}
