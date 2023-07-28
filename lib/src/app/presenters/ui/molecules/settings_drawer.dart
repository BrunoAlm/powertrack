import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/app/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/app/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/avatar.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        shape: const OvalBorder(),
                        shadows: ThemeHelper.shadow(context),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              content: const Text(
                                'Alteração de foto não implementada',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: Theme.of(context).colorScheme.onBackground,
                            shadows: ThemeHelper.shadow(context),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Olá, ',
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      TextSpan(
                        text: widget.loginCt.userConnected.name.toString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Alterar taxa'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'A taxa é o valor que a sua distribuidora de energia cobra por kWh consumido.',
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: taxEC,
                                  decoration: InputDecoration(
                                    hintText: 'Insira o valor',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    prefixIcon: const Icon(Icons.receipt),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancelar',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Container(
                                decoration: ShapeDecoration(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22))),
                                  shadows: ThemeHelper.shadow(context),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    double? taxValue = double.tryParse(
                                        taxEC.text.replaceAll(',', '.'));
                                    if (taxValue != null) {
                                      widget.loginCt.updateTax(taxValue);
                                      Navigator.pop(context);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              'coloque um valor válido'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () => Modular.to.pop(),
                                              child: Text(
                                                'OK',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Alterar',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          )),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Alterar taxa'),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remover dados'),
                        content: RichText(
                          text: TextSpan(
                            text: 'Ao clicar em confirmar, você vai ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'remover',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              ),
                              TextSpan(
                                text: ' seus equipamentos cadastrados',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancelar',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22))),
                              shadows: ThemeHelper.shadow(context),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                widget.equipmentsCt.deleteAllDocuments();
                                Modular.to.pop();
                              },
                              child: Text(
                                'Confirmar',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Apagar equipametos',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                      Icon(Icons.arrow_forward_rounded,
                          color: Theme.of(context).colorScheme.error),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton.filledTonal(
                        onPressed: () => widget.loginCt.updateTheme('dark'),
                        icon: const Icon(
                          Icons.mode_night,
                          size: 32,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton.filledTonal(
                      onPressed: () => widget.loginCt.updateTheme('light'),
                      icon: const Icon(
                        Icons.sunny,
                        size: 32,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    widget.loginCt.logout();
                    Modular.to.popUntil(ModalRoute.withName('/'));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Logout',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(width: 2),
                      const Icon(Icons.logout_rounded, size: 32),
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
