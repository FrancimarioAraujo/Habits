import 'dart:convert';

import 'package:click/app/db/RoutinesDB.dart';
import 'package:click/app/models/Routine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutinesProvider with ChangeNotifier {
  static RoutinesProvider instance = RoutinesProvider();
  final RoutinesDB _routinesDB = RoutinesDB.instance;
  List<Routine> routines = [];

  Routine convertToRoutineModel(dynamic routineQuery) {
    dynamic routineDecoded = jsonDecode(routineQuery);
    return Routine(id: routineDecoded["id"], name: routineDecoded["name"]);
  }

  Future<void> fetchRoutines() async {
    if (routines.isEmpty) {
      await _routinesDB.getRoutines().then((routinesQuery) {
        for (var routineQuery in routinesQuery) {
          routines.add(convertToRoutineModel(routineQuery));
        }
      });
      notifyListeners();
    }
  }

  Future<void> createRoutine(Routine routine) async {
    routines.add(routine);
    await _routinesDB.createRoutine(routine);
    notifyListeners();
  }
}
