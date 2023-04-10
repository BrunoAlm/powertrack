import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uitcc/app/app_module.dart';
import 'package:uitcc/app/app_widget.dart';

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
    (error, stack) {
      print('Error: $error, Stack: $stack');
    },
  );
}
