import 'package:click/app/my_app.dart';
import 'package:click/app/modules/routine/controller/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'app/app_module.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoutineController(),
      child: ModularApp(module: AppModule(), child: const MyApp()),
    ),
  );
}
