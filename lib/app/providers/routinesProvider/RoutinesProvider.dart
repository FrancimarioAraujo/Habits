import 'dart:convert';

import 'package:click/app/db/RoutinesDB.dart';
import 'package:click/app/models/Routine.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class RoutinesProvider with ChangeNotifier {
  static RoutinesProvider instance = RoutinesProvider();
  final RoutinesDB _routinesDB = RoutinesDB.instance;
  final _uuid = const Uuid();
  List<Routine> routines = [];

  String _generateNewRoutineId() {
    return _uuid.v4();
  }

  Routine convertToRoutineModel(
      {dynamic routineQuery, String? id, String? name}) {
    if (id != null && name != null) {
      return Routine(id: id, name: name);
    } else {
      if (routineQuery != null) {
        dynamic routineDecoded = jsonDecode(routineQuery);
        return Routine(id: routineDecoded["id"], name: routineDecoded["name"]);
      }
      return Routine(id: "", name: "");
    }
  }

  Future<void> fetchRoutines() async {
    if (routines.isEmpty) {
      await _routinesDB.getRoutines().then((routinesQuery) {
        for (var routineQuery in routinesQuery) {
          routines.add(convertToRoutineModel(routineQuery: routineQuery));
        }
      });
      notifyListeners();
    }
  }

  Future<void> createRoutine(String name) async {
    Routine routine =
        convertToRoutineModel(id: _generateNewRoutineId(), name: name);
    routines.add(routine);
    await _routinesDB.createRoutine(routine);
    notifyListeners();
  }

  Future<void> deleteRoutine(Routine routine) async {
    routines.remove(routine);
    await _routinesDB.deleteRoutine(routine);
    notifyListeners();
  }
}
