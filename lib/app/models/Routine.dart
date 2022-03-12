final String tableRoutines = "tableRoutines";

class RoutineFields {
  static RoutineFields instance = RoutineFields();
  String id = 'id';
  String name = 'name';
  String concluded = 'concluded';
  String onTrash = 'onTrash';
  String selectedToRestore = 'selectedToRestore';
}

class Routine {
  final String id;
  final String name;
  bool concluded = false;
  bool onTrash = false;
  bool selectedToRestore = false;
  RoutineFields routineFields = RoutineFields.instance;

  Routine({
    required this.id,
    required this.name,
    required this.concluded,
    required this.onTrash,
    required this.selectedToRestore,
  });

  Map<String, Object> toJson() => {
        routineFields.id: id,
        routineFields.name: name,
        routineFields.concluded: concluded ? 1 : 0,
        routineFields.onTrash: onTrash ? 1 : 0,
      };

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, concluded: $concluded, onTrash: $onTrash, selectedToRestore: $selectedToRestore}';
  }
}
