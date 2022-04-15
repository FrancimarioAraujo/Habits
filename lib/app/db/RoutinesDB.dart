import 'dart:convert';

import 'package:click/app/models/Routine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RoutinesDB {
  static final RoutinesDB instance = RoutinesDB._init();
  static Database? _database;
  String idType = 'TEXT PRIMARY KEY';
  String textType = 'TEXT NOT NULL';
  String integerType = 'INTEGER NOT NULL';
  RoutinesDB._init();
  RoutineFields routineFields = RoutineFields.instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('routines.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 4, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableRoutines(
        ${routineFields.id} $idType, 
        ${routineFields.name} $textType,
        ${routineFields.concluded} $integerType,
        ${routineFields.onTrash} $integerType
      )
''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < 5) {
      db.execute(
          "ALTER TABLE $tableRoutines DROP COLUMN ${routineFields.selectedToRestore} $integerType;");
    }
  }

  Future<void> createRoutine(Routine routine) async {
    final db = await instance.database;
    await db.insert(tableRoutines, routine.toMap());
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
    await db.update(tableRoutines, routine.toMap(),
        where: "${routineFields.id} = ?", whereArgs: [routine.id]);
  }

  Future<void> deleteRoutine(Routine routine) async {
    final db = await instance.database;
    await db.delete(tableRoutines,
        where: '${routineFields.id} = ?', whereArgs: [routine.id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
