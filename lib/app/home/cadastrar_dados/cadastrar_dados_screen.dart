import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/home/cadastrar_dados/equipamentos.dart';
import 'package:uitcc/app/home/cadastrar_dados/pesquisa_equipamentos.dart';

class CadastrarDadosScreen extends StatefulWidget {
  const CadastrarDadosScreen({Key? key}) : super(key: key);

  @override
  State<CadastrarDadosScreen> createState() => _CadastrarDadosScreenState();
}

class _CadastrarDadosScreenState extends State<CadastrarDadosScreen> {
  int paginaAtual = 0;
  final Duration _duration = const Duration(milliseconds: 100);
  final Curve _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    // ignore: avoid_print
    print(largura);
    PageController _controller = PageController();
    List<Widget> _paginas = [
      const IntroducaoPorQuePegarDados(),
      const PesquisaEquipamentos(),
      const Page2()
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: _paginas,
            scrollDirection: Axis.horizontal,
          ),
          paginaAtual != 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(40),
                  child: IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            paginaAtual == 0
                ? Container()
                : FloatingActionButton.extended(
                    heroTag: 'voltar',
                    onPressed: () {
                      if (paginaAtual > 0) {
                        paginaAtual--;
                        setState(() {});
                      }
                      _controller.previousPage(
                        duration: _duration,
                        curve: _curve,
                      );
                    },
                    label: const Text('Voltar'),
                  ),
            SizedBox(
              height: 50,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _paginas.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: index == paginaAtual ? 13 : 10,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: index == paginaAtual
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            paginaAtual == _paginas.length - 1
                ? FloatingActionButton.extended(
                    heroTag: 'ok',
                    onPressed: () {},
                    label: const Text('OK'),
                  )
                : FloatingActionButton.extended(
                    heroTag: 'proximo',
                    onPressed: () {
                      _controller.nextPage(duration: _duration, curve: _curve);
                      if (paginaAtual < _paginas.length - 1) {
                        paginaAtual++;
                        setState(() {});
                      }
                    },
                    label: const Text('Próximo'),
                  ),
          ],
        ),
      ),
    );
  }
}

class IntroducaoPorQuePegarDados extends StatelessWidget {
  const IntroducaoPorQuePegarDados({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
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

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Quais destes equipamentos você tem em casa?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 125,
                      child: Text('Equipamento',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 35,
                      child: Text('Qtd',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: Text('Tempo',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 60,
                      child: Text('Potência',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: equipamentos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomWidget(
                          nomeEquipamento: equipamentos[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  final String nomeEquipamento;
  const CustomWidget({Key? key, required this.nomeEquipamento})
      : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  int _tempoUsado = 1;
  int _quantidade = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 125,
          child: Text(
            widget.nomeEquipamento,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 35,
          child: DropdownButton<int>(
            value: _quantidade,
            onChanged: (value) {
              setState(() {
                _quantidade = value!;
              });
            },
            menuMaxHeight: 260,
            itemHeight: 50,
            items: List.generate(5, (index) {
              return DropdownMenuItem(
                value: index + 1,
                child: Text(
                  (index + 1).toString(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 50,
          child: DropdownButton<int>(
            value: _tempoUsado,
            onChanged: (value) {
              setState(() {
                _tempoUsado = value!;
              });
            },
            menuMaxHeight: 260,
            itemHeight: 50,
            items: List.generate(24, (index) {
              return DropdownMenuItem(
                value: index + 1,
                child: Text(
                  '${index + 1}hr',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: Text(
            '1234 kWh',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          // child: TextField(
          //   controller: _controller,
          //   keyboardType: TextInputType.number,
          //   decoration: const InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //     ),
          //     hintText: 'kw/h',
          //   ),
          // ),
        ),
      ],
    );
  }
}
