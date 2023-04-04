import 'package:flutter/material.dart';
import 'package:uitcc/app/home/cadastrar_dados/equipamentos.dart';
import 'package:uitcc/app/home/cadastrar_dados/widgets/equipamentos_selecionados.dart';
import 'package:uitcc/app/home/cadastrar_dados/widgets/result_search_text_field.dart';
import 'package:uitcc/app/home/cadastrar_dados/widgets/search_text_field.dart';
import 'package:uitcc/app/home/controller/equipamentos_store.dart';

class PesquisaEquipamentos extends StatefulWidget {
  const PesquisaEquipamentos({Key? key}) : super(key: key);
  @override
  _PesquisaEquipamentosState createState() => _PesquisaEquipamentosState();
}

class _PesquisaEquipamentosState extends State<PesquisaEquipamentos> {
  final TextEditingController _searchController = TextEditingController();
  final equipamentosStore = EquipamentosStore();
  List<String> _dadosFiltrados = [];
  // ignore: unused_field
  bool _isLoading = false;
  // ignore: unused_field
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _dadosFiltrados = equipamentos;
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
      _isActive = true;
    });

    if (_searchController.text.isEmpty) {
      _isActive = false;
    }

    _dadosFiltrados = equipamentos
        .where((element) => element
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Column(
        children: [
          Text(
            'Quais destes equipamentos você tem em casa?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _isActive
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: SearchTextField(
                    searchController: _searchController,
                  ),
                ),
                _isActive
                    ? ResultSearchTextField(
                        filteredData: _dadosFiltrados,
                        equipamentosStore: equipamentosStore,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
                child:
                    Text('Qtd', style: Theme.of(context).textTheme.titleSmall),
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
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: equipamentosStore,
            builder: (context, value, child) =>
                ListViewEquipamentosSelecionados(
              equipamentosAdicionados: equipamentosStore,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
