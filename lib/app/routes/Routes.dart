import 'package:click/app/routes/RoutesNames.dart';
import 'package:click/app/views/screens/RoutineScreen.dart';
import 'package:click/app/views/screens/TrashScreen.dart';
import 'package:flutter/material.dart';

RoutesNames routesNames = RoutesNames.instance;

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    routesNames.routineScreen: (context) => RoutineScreen(),
    routesNames.trashScreen: (context) => TrashScreen(),
  };
}
