import 'package:flutter/material.dart';
import 'package:uitcc/app/home/widgets/explanation_dialog.dart';

class PesquisaEquipamentos extends StatefulWidget {
  const PesquisaEquipamentos({Key? key}) : super(key: key);
  _PesquisaEquipamentosState createState() => _PesquisaEquipamentosState();
}

class _PesquisaEquipamentosState extends State<PesquisaEquipamentos> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grape',
    'Lemon',
    'Mango',
    'Orange',
    'Papaya',
    'Peach',
    'Plum',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];
  List<String> _filteredData = [];
  bool _isLoading = false;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
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
      Future.delayed(
        const Duration(milliseconds: 0),
        () => showDialog(
          context: context,
          useSafeArea: true,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 250.0),
              child: PesquisaEquipamentoDialog(filteredData: _filteredData),
            ),
          ),
        ),
      );
    });

    if (_searchController.text.isEmpty) {
      _isActive = false;
    }

    // Simulates waiting for an API call
    // await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      _filteredData = _data
          .where((element) => element
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) =>
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.yellow, Colors.orange],
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //       ),
      //     ),
      //   ),
      //   title: TextField(
      //     controller: _searchController,
      //     style: const TextStyle(color: Colors.black),
      //     cursorColor: Colors.black,
      //     decoration: const InputDecoration(
      //       hintText: 'Buscar...',
      //       hintStyle: TextStyle(color: Colors.black54),
      //       border: InputBorder.none,
      //     ),
      //   ),
      // ),
      Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            Text(
              'Quais destes equipamentos você tem em casa?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: const TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
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
          ],

          // body: !_isActive
          //     ? const Center(
          //         child: Text('Busque alguma coisa!',
          //             style: TextStyle(color: Colors.black)),
          //       )
          //     : Center(
          //         child: Container(
          //           height: 150,
          //           decoration: const BoxDecoration(
          //             gradient: LinearGradient(
          //               colors: [Colors.yellow, Colors.orange],
          //               begin: Alignment.topLeft,
          //               end: Alignment.bottomRight,
          //             ),
          //           ),
          //     child: ListView.builder(
          //       itemCount: _filteredData.length,
          //       itemBuilder: (context, index) => ListTile(
          //         title: Text(
          //           _filteredData[index],
          //           style: const TextStyle(color: Colors.black),
          //         ),
          //         trailing: IconButton(
          //             onPressed: () {}, icon: const Icon(Icons.add)),
          //       ),
          //     ),
          //   ),
          // ),
          // backgroundColor: Colors.white,
        ),
      );
}

class PesquisaEquipamentoDialog extends StatelessWidget {
  const PesquisaEquipamentoDialog({Key? key, required this.filteredData})
      : super(key: key);
  final List<String> filteredData;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 200,
        width: 300,
        color: Colors.red,
        child: ListView.builder(
          itemCount: filteredData.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              filteredData[index],
              style: const TextStyle(color: Colors.black),
            ),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          ),
        ),
      ),
    );
  }
}
