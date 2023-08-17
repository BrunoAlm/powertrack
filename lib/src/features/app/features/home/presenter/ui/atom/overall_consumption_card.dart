import 'package:flutter/material.dart';
import 'package:uitcc/src/features/app/features/equipments/presenters/controllers/equipments_controller.dart';
import 'package:uitcc/src/features/login/presenters/controllers/login_controller.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class OverallConsumptionCard extends StatelessWidget {
  final EquipmentsController equipmentsController;
  final LoginController loginController;
  const OverallConsumptionCard({
    super.key,
    required this.equipmentsController,
    required this.loginController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: ThemeHelper.shadow(context),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('kW/h', style: Theme.of(context).textTheme.bodyLarge!),
                  Text(
                    Helper.formatDouble(
                        equipmentsController.totalConsumption()),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Container(
                width: 1.5,
                color: Theme.of(context).disabledColor,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Valor a pagar',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                  ),
                  Visibility(
                      visible: loginController.userPrefs.tax == 0.0,
                      replacement: Text(
                        'R\$${Helper.formatDouble(equipmentsController.totalCost(loginController.userPrefs.tax))}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      child: const Text(
                        'Taxa não pode ser 0',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              Container(
                width: 1.5,
                color: Theme.of(context).disabledColor,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Equip.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                  ),
                  Text(
                    '${equipmentsController.totalEquipments()}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
