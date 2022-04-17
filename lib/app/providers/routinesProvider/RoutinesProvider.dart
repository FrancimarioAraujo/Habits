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

  Future<void> selectOrDeselectToRestore(Routine routine, bool value) async {
    routine.selectedToRestore = value;
    notifyListeners();
  }

  List<Routine> getAllRoutinesSelectedOnTrash() {
    List<Routine> routinesOnTrash = getAllRoutinesOnTrash();
    List<Routine> routinesSelectedOnTrash = routinesOnTrash
        .where((routineOnTrash) => routineOnTrash.selectedToRestore)
        .toList();
    return routinesSelectedOnTrash;
  }

  Future<void> restoreElementsSelectedFromTrash() async {
    List<Routine> routinesSelectedOnTrash = getAllRoutinesSelectedOnTrash();
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
      {required Routine routine, required bool onTrash}) async {
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

  Future<void> fetchRoutines() async {
    if (routines.isEmpty) {
      List<dynamic> routinesQuery = await _routinesDB.getRoutines();
      for (var routineQuery in routinesQuery) {
        routines.add(Routine.fromJson(routineQuery));
      }
      notifyListeners();
    }
  }

  Future<void> createRoutine(String name) async {
    Routine routine = Routine.fromMap(
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

  Future<void> deleteRoutine(Routine routine) async {
    routines.remove(routine);
    await _routinesDB.deleteRoutine(routine);
    notifyListeners();
  }
}
