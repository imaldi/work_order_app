import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:work_order_app/core/helpers/database_helper.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUp(() async {
    // Inisialisasi sqflite_common_ffi untuk pengujian
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    databaseHelper = DatabaseHelper();
  });

  tearDown(() async {
    final db = await databaseHelper.database;
    await db.close();
  });

  group('DatabaseHelper', () {
    test('should create database with work_orders and technicians tables', () async {
      // Gunakan database in-memory untuk pengujian
      final db = await openDatabase(inMemoryDatabasePath, version: 1, onCreate: databaseHelper.createDB);

      final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
      final tableNames = tables.map((table) => table['name']).toList();

      expect(tableNames, contains('work_orders'));
      expect(tableNames, contains('technicians'));

      await db.close();
    });
  });
}