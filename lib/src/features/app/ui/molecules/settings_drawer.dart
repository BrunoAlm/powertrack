import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/app/features/home/presenter/store/home_store.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/features/app/ui/atoms/change_tax_dialog.dart';
import 'package:uitcc/src/features/app/ui/atoms/improvements_dialog.dart';
import 'package:uitcc/src/features/app/ui/atoms/remove_data_dialog.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class SettingsDrawer extends StatefulWidget {
  final LoginController loginCt;
  final AppStore homeStore;
  final EquipmentsController equipmentsCt;
  const SettingsDrawer({
    Key? key,
    required this.loginCt,
    required this.equipmentsCt,
    required this.homeStore,
  }) : super(key: key);

  @override
  SettingsDrawerState createState() => SettingsDrawerState();
}

class SettingsDrawerState extends State<SettingsDrawer> {
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
                          Helper.notImplementedSnackbar(context);
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
                    builder: (context) => ChangeTaxDialog(
                      loginCt: widget.loginCt,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Alterar taxa',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const ImprovementsDialog(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Melhorias no app',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Icon(Icons.arrow_forward_rounded),
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
                      builder: (context) => RemoveDataDialog(
                        equipmentsCt: widget.equipmentsCt,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Apagar equipametos',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                    Modular.to.popUntil(ModalRoute.withName('/'));
                    widget.loginCt.logout();
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
