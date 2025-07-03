import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@lazySingleton
class DatabaseHelper {
  static Database? _database;
  // final String? testDbPath;

  @factoryMethod
  DatabaseHelper(
      // {this.testDbPath}
      );

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(
        // this.testDbPath ??
        'work_order_app.db');
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
        customId TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        priority TEXT NOT NULL,
        status TEXT NOT NULL,
        dueDate TEXT NOT NULL,
        scheduledStart TEXT NOT NULL,
        scheduledEnd TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        technicianId INTEGER NOT NULL,
        groupId INTEGER NOT NULL,
        materials TEXT NOT NULL,
        photoPath TEXT NOT NULL,
        attachmentPath TEXT NOT NULL,
        location TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        FOREIGN KEY (technicianId) REFERENCES technicians(id)
        FOREIGN KEY (groupId) REFERENCES work_order_groups(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE technicians (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE work_order_groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        createdBy INTEGER NOT NULL,
        FOREIGN KEY (createdBy) REFERENCES technicians(id)
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}