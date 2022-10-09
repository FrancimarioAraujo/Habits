// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoutineController on _RoutineController, Store {
  late final _$routinesAtom =
      Atom(name: '_RoutineController.routines', context: context);

  @override
  List<RoutineModel> get routines {
    _$routinesAtom.reportRead();
    return super.routines;
  }

  @override
  set routines(List<RoutineModel> value) {
    _$routinesAtom.reportWrite(value, super.routines, () {
      super.routines = value;
    });
  }

  late final _$concludeOrMarkOffRoutineAsyncAction = AsyncAction(
      '_RoutineController.concludeOrMarkOffRoutine',
      context: context);

  @override
  Future<void> concludeOrMarkOffRoutine(RoutineModel routine, bool value) {
    return _$concludeOrMarkOffRoutineAsyncAction
        .run(() => super.concludeOrMarkOffRoutine(routine, value));
  }

  late final _$selectOrDeselectToRestoreAsyncAction = AsyncAction(
      '_RoutineController.selectOrDeselectToRestore',
      context: context);

  @override
  Future<void> selectOrDeselectToRestore(RoutineModel routine, bool value) {
    return _$selectOrDeselectToRestoreAsyncAction
        .run(() => super.selectOrDeselectToRestore(routine, value));
  }

  late final _$restoreElementsSelectedFromTrashAsyncAction = AsyncAction(
      '_RoutineController.restoreElementsSelectedFromTrash',
      context: context);

  @override
  Future<void> restoreElementsSelectedFromTrash() {
    return _$restoreElementsSelectedFromTrashAsyncAction
        .run(() => super.restoreElementsSelectedFromTrash());
  }

  late final _$clearTrashAsyncAction =
      AsyncAction('_RoutineController.clearTrash', context: context);

  @override
  Future<void> clearTrash() {
    return _$clearTrashAsyncAction.run(() => super.clearTrash());
  }

  late final _$addOrRemoveRoutineFromTrashAsyncAction = AsyncAction(
      '_RoutineController.addOrRemoveRoutineFromTrash',
      context: context);

  @override
  Future<void> addOrRemoveRoutineFromTrash(
      {required RoutineModel routine, required bool onTrash}) {
    return _$addOrRemoveRoutineFromTrashAsyncAction.run(() =>
        super.addOrRemoveRoutineFromTrash(routine: routine, onTrash: onTrash));
  }

  late final _$fetchRoutinesAsyncAction =
      AsyncAction('_RoutineController.fetchRoutines', context: context);

  @override
  Future<void> fetchRoutines() {
    return _$fetchRoutinesAsyncAction.run(() => super.fetchRoutines());
  }

  late final _$createRoutineAsyncAction =
      AsyncAction('_RoutineController.createRoutine', context: context);

  @override
  Future<void> createRoutine(String name) {
    return _$createRoutineAsyncAction.run(() => super.createRoutine(name));
  }

  late final _$deleteRoutineAsyncAction =
      AsyncAction('_RoutineController.deleteRoutine', context: context);

  @override
  Future<void> deleteRoutine(RoutineModel routine) {
    return _$deleteRoutineAsyncAction.run(() => super.deleteRoutine(routine));
  }

  @override
  String toString() {
    return '''
routines: ${routines}
    ''';
  }
}
