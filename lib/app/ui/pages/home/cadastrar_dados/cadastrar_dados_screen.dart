import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/pages/equipments_introduction_page.dart';
import 'package:uitcc/app/ui/pages/home/cadastrar_dados/pages/register_equipments_page.dart';
import 'package:uitcc/app/ui/stores/equipments_store.dart';
import 'package:uitcc/app/ui/stores/login_store.dart';

class CadastrarDadosScreen extends StatefulWidget {
  const CadastrarDadosScreen({Key? key}) : super(key: key);

  @override
  State<CadastrarDadosScreen> createState() => _CadastrarDadosScreenState();
}

class _CadastrarDadosScreenState extends State<CadastrarDadosScreen> {
  int paginaAtual = 0;
  final Duration _duration = const Duration(milliseconds: 100);
  final Curve _curve = Curves.ease;
  final EquipmentsStore equipmentStore = Modular.get();
  final LoginStore loginStore = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _largura = MediaQuery.of(context).size.width;
    double _altura = MediaQuery.of(context).size.height;
    PageController _controller = PageController();

    List<Widget> _paginas = [
      const EquipmentsIntroduction(),
      const RegisterEquipments(),
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
                          onPressed: () {
                            equipmentStore
                                .createDocument(equipmentStore.equipments);

                            Modular.to.pushNamed('home-page');
                          },
                          label: const Text('OK'),
                        )
                      : FloatingActionButton.extended(
                          heroTag: 'proximo',
                          onPressed: () {
                            loginStore.getUserData();
                            equipmentStore.listDocuments();

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
