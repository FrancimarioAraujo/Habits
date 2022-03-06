import 'package:click/app/routes/RoutesNames.dart';
import 'package:click/app/screens/RoutineScreen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesNames.instance.routineScreen: (context) => RoutineScreen(),
  };
}
