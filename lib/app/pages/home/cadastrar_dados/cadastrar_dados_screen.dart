import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/pages/home/cadastrar_dados/widgets/pesquisa_equipamentos.dart';

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
    double _largura = MediaQuery.of(context).size.width;
    double _altura = MediaQuery.of(context).size.height;
    // ignore: avoid_print
    print(_largura);
    PageController _controller = PageController();
    List<Widget> _paginas = [
      const IntroducaoPorQuePegarDados(),
      const PesquisaEquipamentos(),
    ];
    return Material(
      child: SizedBox(
        height: _altura,
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: _paginas,
              physics: const NeverScrollableScrollPhysics(),
            ),
            Positioned(
              bottom: 25,
              width: _largura,
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
                                    ? Theme.of(context)
                                        .colorScheme
                                        .inversePrimary
                                    : Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
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
                            _controller.nextPage(
                                duration: _duration, curve: _curve);
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
      ),
    );
  }
}

class IntroducaoPorQuePegarDados extends StatelessWidget {
  const IntroducaoPorQuePegarDados({super.key});

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
