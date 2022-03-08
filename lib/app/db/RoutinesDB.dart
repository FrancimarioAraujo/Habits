import 'dart:convert';

import 'package:click/app/models/Routine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RoutinesDB {
  static final RoutinesDB instance = RoutinesDB._init();
  static Database? _database;
  RoutinesDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('routines.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    await db.execute('''
      CREATE TABLE $tableRoutines(
        ${RoutineFields.id} $idType, 
        ${RoutineFields.name} $textType,
        ${RoutineFields.concluded} $integerType 
      )
''');
  }

  Future<void> createRoutine(Routine routine) async {
    final db = await instance.database;
    await db.insert(tableRoutines, routine.toJson());
  }

  Future<List> getRoutines() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> routines =
        await db.rawQuery("SELECT * FROM $tableRoutines");
    List listRoutines = [];
    for (Map routine in routines) {
      listRoutines.add(json.encode(routine));
    }
    return listRoutines;
  }

  Future<void> updateRoutine(Routine routine) async {
    final db = await instance.database;
    await db.update(tableRoutines, routine.toJson(),
        where: "${RoutineFields.id} = ?", whereArgs: [routine.id]);
  }

  Future<void> deleteRoutine(Routine routine) async {
    final db = await instance.database;
    await db.delete(tableRoutines,
        where: '${RoutineFields.id} = ?', whereArgs: [routine.id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
