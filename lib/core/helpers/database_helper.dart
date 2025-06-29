import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@singleton
class DatabaseHelper {
  static Database? _database;

  @factoryMethod
  DatabaseHelper();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('work_order.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: createDB,
    );
  }

  /// Only exposed for testing
  @visibleForTesting
  Future createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE work_orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        priority TEXT NOT NULL,
        status TEXT NOT NULL,
        dueDate TEXT NOT NULL,
        technicianId TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        FOREIGN KEY (technicianId) REFERENCES technicians(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE technicians (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact TEXT
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}