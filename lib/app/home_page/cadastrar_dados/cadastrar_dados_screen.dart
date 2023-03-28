import 'package:flutter/material.dart';
import 'package:uitcc/app/home_page/cadastrar_dados/equipamentos.dart';

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
    PageController _controller = PageController();
    List<Widget> _paginas = [
      const IntroducaoPorQuePegarDados(),
      const Page2(),
      const Page2(),
      const Page2(),
      const Page2(),
      const Page2(),
    ];
    return Scaffold(
      appBar: paginaAtual != 0
          ? const PreferredSize(
              preferredSize: Size(0, 0),
              child: SizedBox(),
            )
          : AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 38.0),
        child: PageView(
          controller: _controller,
          children: _paginas,
          scrollDirection: Axis.horizontal,
        ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conhecendo seus gastos:',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          'Para calcular os custos, é precisamos saber quais são os gastos energético da sua casa.',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          'Preencha os dados com a maior precisão possível.',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Quais destes equipamentos você tem em casa?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('Equipamento',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 70,
                    child: Text('Quantidade',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 90,
                    child: Text('Dias utilizados',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 60,
                    child: Text('Consumo',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomWidget(
                      nomeEquipamento: equipamentos[index + 15],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
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
  int _diaSelecionado = 1;
  int _quantidade = 1;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            widget.nomeEquipamento,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(width: 18),
        SizedBox(
          width: 70,
          child: Center(
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
                  child: Text((index + 1).toString()),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 18),
        SizedBox(
          width: 90,
          child: Center(
            child: DropdownButton<int>(
              value: _diaSelecionado,
              onChanged: (value) {
                setState(() {
                  _diaSelecionado = value!;
                });
              },
              menuMaxHeight: 260,
              itemHeight: 50,
              items: List.generate(31, (index) {
                return DropdownMenuItem(
                  value: index + 1,
                  child: Text((index + 1).toString()),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Container(
          padding: const EdgeInsets.all(8),
          width: 80,
          child: const Text('Consumo kw/h'),
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
