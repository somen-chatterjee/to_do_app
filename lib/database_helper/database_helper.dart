import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get getDb async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newVersion) async {
        await db.execute('''
          CREATE TABLE Tasks (
            id INTEGER PRIMARY KEY,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }
}