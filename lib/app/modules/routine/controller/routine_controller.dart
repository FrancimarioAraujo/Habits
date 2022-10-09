import 'package:click/app/modules/routine/routines_db.dart';
import 'package:click/app/modules/routine/model/routine_model.dart';
import 'package:uuid/uuid.dart';

import 'package:mobx/mobx.dart';

part 'routine_controller.g.dart';

class RoutineController = _RoutineController with _$RoutineController;

abstract class _RoutineController with Store {
  final RoutinesDB _routinesDB = RoutinesDB.instance;
  final _uuid = const Uuid();

  @observable
  List<RoutineModel> routines = ObservableList<RoutineModel>();

  String _generateNewRoutineId() {
    return _uuid.v4();
  }

  @action
  Future<void> concludeOrMarkOffRoutine(
      RoutineModel routine, bool value) async {
    routine.concluded = value;
    await _routinesDB.updateRoutine(routine);
  }

  @action
  Future<void> selectOrDeselectToRestore(
      RoutineModel routine, bool value) async {
    routine.selectedToRestore = value;
  }

  List<RoutineModel> getAllRoutinesSelectedOnTrash() {
    List<RoutineModel> routinesOnTrash = getAllRoutinesOnTrash();
    List<RoutineModel> routinesSelectedOnTrash = routinesOnTrash
        .where((routineOnTrash) => routineOnTrash.selectedToRestore)
        .toList();
    return routinesSelectedOnTrash;
  }

  @action
  Future<void> restoreElementsSelectedFromTrash() async {
    List<RoutineModel> routinesSelectedOnTrash =
        getAllRoutinesSelectedOnTrash();
    for (var routineSelectedOnTrash in routinesSelectedOnTrash) {
      routineSelectedOnTrash.onTrash = false;
      routineSelectedOnTrash.selectedToRestore = false;
      await _routinesDB.updateRoutine(routineSelectedOnTrash);
    }
  }

  @action
  Future<void> clearTrash() async {
    for (var routineOnTrash in getAllRoutinesOnTrash()) {
      routines.remove(routineOnTrash);
      await _routinesDB.deleteRoutine(routineOnTrash);
    }
  }

  @action
  Future<void> addOrRemoveRoutineFromTrash(
      {required RoutineModel routine, required bool onTrash}) async {
    routine.onTrash = onTrash;
    await _routinesDB.updateRoutine(routine);
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

  @action
  Future<void> fetchRoutines() async {
    if (routines.isEmpty) {
      List<dynamic> routinesQuery = await _routinesDB.getRoutines();
      for (var routineQuery in routinesQuery) {
        routines.add(RoutineModel.fromJson(routineQuery));
      }
    }
  }

  @action
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
  }

  @action
  Future<void> deleteRoutine(RoutineModel routine) async {
    routines.remove(routine);
    await _routinesDB.deleteRoutine(routine);
  }
}
