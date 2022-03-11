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

  Future<void> concludeOrMarkOffRoutine(Routine routine, bool value) async {
    routine.concluded = value;
    await _routinesDB.updateRoutine(routine);
    notifyListeners();
  }

  Future<void> addOrRemoveRoutineFromTrash(
      Routine routine, bool onTrash) async {
    routine.onTrash = onTrash;
    await _routinesDB.updateRoutine(routine);
    notifyListeners();
  }

  List<Routine> getAllRoutinesOnTrash() {
    List<Routine> routinesOnTrash = [];
    routinesOnTrash = routines.where((routine) => routine.onTrash).toList();
    return routinesOnTrash;
  }

  List<Routine> getAllRoutinesOutSideFromTrash() {
    List<Routine> routinesOutSideFromTrash = [];
    routinesOutSideFromTrash =
        routines.where((routine) => !routine.onTrash).toList();
    return routinesOutSideFromTrash;
  }

  Routine convertToRoutineModel(
      {dynamic routineQuery,
      String? id,
      String? name,
      bool? concluded,
      bool? onTrash}) {
    if (id != null && name != null && concluded != null && onTrash != null) {
      return Routine(
          id: id, name: name, concluded: concluded, onTrash: onTrash);
    } else {
      if (routineQuery != null) {
        dynamic routineDecoded = jsonDecode(routineQuery);
        return Routine(
            id: routineDecoded["id"],
            name: routineDecoded["name"],
            concluded: routineDecoded["concluded"] == 1,
            onTrash: routineDecoded["onTrash"] == 1);
      }
      return Routine(id: "", name: "", concluded: false, onTrash: false);
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
    Routine routine = convertToRoutineModel(
        id: _generateNewRoutineId(),
        name: name,
        concluded: false,
        onTrash: false);
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
