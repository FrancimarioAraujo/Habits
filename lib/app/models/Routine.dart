class Routine {
  final String id;
  final String name;

  Routine({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name}';
  }
}
