final String tableRoutines = "tableRoutines";

class RoutineFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String concluded = 'concluded';
  static const String onTrash = 'onTrash';
}

class Routine {
  final String id;
  final String name;
  bool concluded = false;
  bool onTrash = false;

  Routine({
    required this.id,
    required this.name,
    required this.concluded,
    required this.onTrash,
  });

  Map<String, Object> toJson() => {
        RoutineFields.id: id,
        RoutineFields.name: name,
        RoutineFields.concluded: concluded ? 1 : 0,
        RoutineFields.onTrash: onTrash ? 1 : 0,
      };

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, concluded: $concluded, onTrash: $onTrash}';
  }
}
