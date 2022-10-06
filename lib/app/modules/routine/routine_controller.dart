import 'package:click/app/modules/routine/routines_db.dart';
import 'package:click/app/modules/routine/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RoutineController with ChangeNotifier {
  static RoutineController instance = RoutineController();
  final RoutinesDB _routinesDB = RoutinesDB.instance;
  final _uuid = const Uuid();
  List<RoutineModel> routines = [];

  String _generateNewRoutineId() {
    return _uuid.v4();
  }

  Future<void> concludeOrMarkOffRoutine(RoutineModel routine, bool value) async {
    routine.concluded = value;
    await _routinesDB.updateRoutine(routine);
    notifyListeners();
  }

  Future<void> selectOrDeselectToRestore(RoutineModel routine, bool value) async {
    routine.selectedToRestore = value;
    notifyListeners();
  }

  List<RoutineModel> getAllRoutinesSelectedOnTrash() {
    List<RoutineModel> routinesOnTrash = getAllRoutinesOnTrash();
    List<RoutineModel> routinesSelectedOnTrash = routinesOnTrash
        .where((routineOnTrash) => routineOnTrash.selectedToRestore)
        .toList();
    return routinesSelectedOnTrash;
  }

  Future<void> restoreElementsSelectedFromTrash() async {
    List<RoutineModel> routinesSelectedOnTrash = getAllRoutinesSelectedOnTrash();
    for (var routineSelectedOnTrash in routinesSelectedOnTrash) {
      routineSelectedOnTrash.onTrash = false;
      routineSelectedOnTrash.selectedToRestore = false;
      await _routinesDB.updateRoutine(routineSelectedOnTrash);
      notifyListeners();
    }
  }

  Future<void> clearTrash() async {
    for (var routineOnTrash in getAllRoutinesOnTrash()) {
      routines.remove(routineOnTrash);
      await _routinesDB.deleteRoutine(routineOnTrash);
    }
    notifyListeners();
  }

  Future<void> addOrRemoveRoutineFromTrash(
      {required RoutineModel routine, required bool onTrash}) async {
    routine.onTrash = onTrash;
    await _routinesDB.updateRoutine(routine);
    notifyListeners();
  }

  List<RoutineModel> getAllRoutinesOnTrash() {
    List<RoutineModel> routinesOnTrash = [];
    routinesOnTrash = routines.where((routine) => routine.onTrash).toList();
    return routinesOnTrash;
  }

  List<RoutineModel> getAllRoutinesOutSideFromTrash() {
    List<RoutineModel> routinesOutSideFromTrash = [];
    routinesOutSideFromTrash =
        routines.where((routine) => !routine.onTrash).toList();
    return routinesOutSideFromTrash;
  }

  Future<void> fetchRoutines() async {
    if (routines.isEmpty) {
      List<dynamic> routinesQuery = await _routinesDB.getRoutines();
      for (var routineQuery in routinesQuery) {
        routines.add(RoutineModel.fromJson(routineQuery));
      }
      notifyListeners();
    }
  }

  Future<void> createRoutine(String name) async {
    RoutineModel routine = RoutineModel.fromMap(
      {
        "id": _generateNewRoutineId(),
        "name": name,
        "concluded": false,
        "onTrash": false,
        "selectedToRestore": false
      },
    );
    routines.add(routine);
    await _routinesDB.createRoutine(routine);
    notifyListeners();
  }

  Future<void> deleteRoutine(RoutineModel routine) async {
    routines.remove(routine);
    await _routinesDB.deleteRoutine(routine);
    notifyListeners();
  }
}
