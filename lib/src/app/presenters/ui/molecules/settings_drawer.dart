import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';

class SettingsDrawer extends StatefulWidget {
  final LoginController loginCt;
  final EquipmentsController equipmentsCt;
  const SettingsDrawer({
    Key? key,
    required this.loginCt,
    required this.equipmentsCt,
  }) : super(key: key);

  @override
  SettingsDrawerState createState() => SettingsDrawerState();
}

class SettingsDrawerState extends State<SettingsDrawer> {
  late TextEditingController taxEC;

  @override
  void initState() {
    super.initState();
    taxEC =
        TextEditingController(text: widget.loginCt.userPrefs.tax.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Olá, ${widget.loginCt.userConnected.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                widget.equipmentsCt.deleteAllDocuments();
              },
              child: const Text('Apagar dados'),
            ),
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
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => widget.loginCt.updateTheme('light'),
                      icon: const Icon(Icons.sunny),
                    ),
                    const SizedBox(width: 15),
                    IconButton.filledTonal(
                      onPressed: () => widget.loginCt.updateTheme('dark'),
                      icon: const Icon(Icons.mode_night),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    widget.loginCt.logout();
                    Modular.to.popUntil(ModalRoute.withName('/'));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Logout'),
                      SizedBox(width: 4),
                      Icon(Icons.logout, size: 28),
                    ],
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
