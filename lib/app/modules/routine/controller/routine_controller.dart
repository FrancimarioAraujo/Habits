import 'package:click/app/modules/routine/db/routines_db.dart';
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

  String _generateNewRoutineId() {
    return _uuid.v4();
  }

  RoutineModel getRoutine(RoutineModel routine) {
    return routines.firstWhere((element) => element.id == routine.id);
  }

  @action
  Future<void> concludeOrMarkOffRoutine(
      RoutineModel routine, bool value) async {
    routine.concluded = value;
    await updateRoutine(routine);
  }

  @action
  Future<void> updateRoutine(RoutineModel routine) async {
    int indexOfRoutine = routines.indexOf(routine);
    routines[indexOfRoutine] = routine;
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
