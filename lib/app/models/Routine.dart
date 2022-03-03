final String tableRoutines = "tableRoutines";

class RoutineFields {
  static final String id = 'id';
  static final String name = 'name';
}

class Routine {
  final String id;
  final String name;

  Routine({
    required this.id,
    required this.name,
  });

  Map<String, Object> toJson() => {
        RoutineFields.id: id,
        RoutineFields.name: name,
      };

  @override
  String toString() {
    return 'Dog{id: $id, name: $name}';
  }
}
