final String tableRoutines = "tableRoutines";

class RoutineFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String concluded = 'concluded';
}

class Routine {
  final String id;
  final String name;
  bool concluded = false;

  Routine({
    required this.id,
    required this.name,
    required this.concluded,
  });

  Map<String, Object> toJson() => {
        RoutineFields.id: id,
        RoutineFields.name: name,
        RoutineFields.concluded: concluded ? 1 : 0,
      };

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, concluded: $concluded}';
  }
}
