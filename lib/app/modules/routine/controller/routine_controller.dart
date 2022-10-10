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

  @observable
  bool isLoading = false;

  @computed
  List<RoutineModel> get routinesOutSideFromTrash =>
      routines.where((routine) => !routine.onTrash).toList();

  @computed
  List<RoutineModel> get routinesOnTrash =>
      routines.where((routine) => routine.onTrash).toList();

  @computed
  List<RoutineModel> get routinesSelectedOnTrash => routinesOnTrash
      .where((routineOnTrash) => routineOnTrash.selectedToRestore)
      .toList();

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
    routinesSelectedOnTrash.add(routine);
  }

  @action
  Future<void> restoreElementsSelectedFromTrash() async {
    for (var routineSelectedOnTrash in routinesSelectedOnTrash) {
      routineSelectedOnTrash.onTrash = false;
      routineSelectedOnTrash.selectedToRestore = false;
      await _routinesDB.updateRoutine(routineSelectedOnTrash);
    }
  }

  @action
  Future<void> clearTrash() async {
    for (var routineOnTrash in routinesOnTrash) {
      routines.remove(routineOnTrash);
      await _routinesDB.deleteRoutine(routineOnTrash);
    }
  }

  @action
  Future<void> addOrRemoveRoutineFromTrash(
      {required RoutineModel routine, required bool onTrash}) async {
    routine.onTrash = onTrash;
    if (onTrash) {
      routinesOutSideFromTrash.remove(routine);
    } else {
      routinesOutSideFromTrash.add(routine);
    }
    await _routinesDB.updateRoutine(routine);
  }

  @action
  Future<void> fetchRoutines() async {
    if (routines.isEmpty) {
      isLoading = true;
      List<dynamic> routinesQuery = await _routinesDB.getRoutines();
      for (var routineQuery in routinesQuery) {
        routines.add(RoutineModel.fromJson(routineQuery));
      }
      isLoading = false;
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
