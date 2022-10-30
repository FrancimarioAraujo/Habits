import 'dart:convert';

import 'package:mobx/mobx.dart';

final String tableRoutines = "tableRoutines";

class RoutineFields {
  static RoutineFields instance = RoutineFields();
  String id = 'id';
  String name = 'name';
  String concluded = 'concluded';

  String selectedToRestore = 'selectedToRestore';
}

class RoutineModel {
  final String id;
  final String name;
  @observable
  bool concluded = false;

  bool selectedToRestore = false;
  RoutineFields routineFields = RoutineFields.instance;

  RoutineModel({
    required this.id,
    required this.name,
    required this.concluded,
    required this.selectedToRestore,
  });

  @override
  String toString() {
    return 'Routine(id: $id, name: $name, concluded: $concluded, selectedToRestore: $selectedToRestore)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'concluded': concluded ? 1 : 0});

    return result;
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      concluded: map['concluded'] == 1,
      selectedToRestore: map['selectedToRestore'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoutineModel.fromJson(String source) =>
      RoutineModel.fromMap(json.decode(source));
}
