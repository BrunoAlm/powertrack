// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:uitcc/app/ui/pages/home/cadastrar_dados/pages/equipments_introduction_page.dart';
// import 'package:uitcc/app/ui/pages/home/cadastrar_dados/pages/register_equipments_page.dart';
// import 'package:uitcc/app/ui/stores/equipments_store.dart';
// import 'package:uitcc/app/ui/stores/login_store.dart';

// class CadastrarDadosScreen extends StatefulWidget {
//   const CadastrarDadosScreen({Key? key}) : super(key: key);

//   @override
//   State<CadastrarDadosScreen> createState() => _CadastrarDadosScreenState();
// }

// class _CadastrarDadosScreenState extends State<CadastrarDadosScreen> {
//   int paginaAtual = 0;
//   final Duration _duration = const Duration(milliseconds: 100);
//   final Curve _curve = Curves.ease;
//   final EquipmentsStore equipmentStore = Modular.get();
//   final LoginStore loginStore = Modular.get();

//   @override
//   Widget build(BuildContext context) {
//     double largura = MediaQuery.of(context).size.width;
//     double altura = MediaQuery.of(context).size.height;
//     PageController controller = PageController();

//     List<Widget> paginas = [
//       const EquipmentsIntroduction(),
//       RegisterEquipments(
//         equipmentsStore: equipmentStore,
//         widgetHeight: altura,
//       ),
//     ];

//     return Material(
//       child: SizedBox(
//         height: altura,
//         child: Stack(
//           children: [
//             PageView(
//               controller: controller,
//               physics: const NeverScrollableScrollPhysics(),
//               children: paginas,
//             ),
//             Positioned(
//               bottom: 25,
//               width: largura,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   paginaAtual == 0
//                       ? Container()
//                       : FloatingActionButton.extended(
//                           heroTag: 'voltar',
//                           onPressed: () {
//                             if (paginaAtual > 0) {
//                               paginaAtual--;
//                               setState(() {});
//                             }
//                             controller.previousPage(
//                               duration: _duration,
//                               curve: _curve,
//                             );
//                           },
//                           label: const Text('Voltar'),
//                         ),
//                   SizedBox(
//                     height: 50,
//                     child: Center(
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: paginas.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Center(
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 4),
//                               height: index == paginaAtual ? 13 : 10,
//                               width: 20,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 color: index == paginaAtual
//                                     ? Theme.of(context)
//                                         .colorScheme
//                                         .inversePrimary
//                                     : Theme.of(context)
//                                         .colorScheme
//                                         .inverseSurface,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   paginaAtual == paginas.length - 1
//                       ? FloatingActionButton.extended(
//                           heroTag: 'ok',
//                           onPressed: () {
//                             equipmentStore.createDocument(
//                                 equipmentStore.loadedEquipments);

//                             Modular.to.popUntil(ModalRoute.withName('/home/'));
//                           },
//                           label: const Text('OK'),
//                         )
//                       : FloatingActionButton.extended(
//                           heroTag: 'proximo',
//                           onPressed: () {
//                             loginStore.getUserData();
//                             equipmentStore.listDocuments();

//                             controller.nextPage(
//                                 duration: _duration, curve: _curve);
//                             if (paginaAtual < paginas.length - 1) {
//                               paginaAtual++;
//                               setState(() {});
//                             }
//                           },
//                           label: const Text('Próximo'),
//                         ),
//                 ],
//               ),
//             ),
//             paginaAtual != 0
//                 ? const SizedBox()
//                 : Padding(
//                     padding: const EdgeInsets.all(40),
//                     child: IconButton(
//                       onPressed: () => Modular.to.pop(),
//                       icon: const Icon(Icons.arrow_back),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
