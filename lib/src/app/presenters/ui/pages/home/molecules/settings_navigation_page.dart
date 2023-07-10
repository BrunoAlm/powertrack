// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';

class SettingsNavigationPage extends StatefulWidget {
  final LoginController loginCt;
  final EquipmentsController equipmentsCt;
  const SettingsNavigationPage({
    Key? key,
    required this.loginCt,
    required this.equipmentsCt,
  }) : super(key: key);

  @override
  State<SettingsNavigationPage> createState() => _SettingsNavigationPageState();
}

class _SettingsNavigationPageState extends State<SettingsNavigationPage> {
  late TextEditingController taxEC;

  @override
  void initState() {
    taxEC =
        TextEditingController(text: widget.loginCt.userPrefs.tax.toString());
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton.filledTonal(
            onPressed: () => widget.loginCt.alternateTheme(),
            icon: const Icon(Icons.sunny),
          ),
          const Spacer(),
          Text(
            widget.loginCt.userConnected.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.loginCt.logout();
                  Modular.to.popUntil(ModalRoute.withName('/'));
                },
                child: const Text('Desconectar'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.equipmentsCt.deleteAllDocuments();
                  // setState(() {
                  //   widget.equipmentsStore.listDocuments();
                  // });
                },
                child: const Text('APAGAR equipamentos cadastrados'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: TextFormField(
                      controller: taxEC,
                      decoration: InputDecoration(
                        hintText: 'Taxa de energia',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        double? taxValue =
                            double.tryParse(taxEC.text.replaceAll(',', '.'));
                        if (taxValue != null) {
                          widget.loginCt.updateTax(taxValue);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('coloque um valor válido'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Modular.to.pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
