import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/src/features/app/app_module.dart';
import 'package:uitcc/src/features/app_widget.dart';

void main() {
  return runZonedGuarded(
    () async {
      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    },
    (error, stack) {},
  );
}