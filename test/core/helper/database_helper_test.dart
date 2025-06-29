import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:work_order_app/core/helpers/database_helper.dart';
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart';
import 'package:work_order_app/features/work_order/data/models/work_order_model.dart';

void main() {
  late DatabaseHelper databaseHelper;
  late WorkOrderLocalDataSourceImpl dataSource;

  setUp(() async {
    databaseFactory = databaseFactoryFfi;
    databaseHelper = DatabaseHelper();
    dataSource = WorkOrderLocalDataSourceImpl(databaseHelper);
    final db = await databaseHelper.database;
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
        longitude REAL NOT NULL
      )
    ''');
  });

  tearDown(() async {
    final db = await databaseHelper.database;
    await db.close();
  });

  group('WorkOrderLocalDataSourceImpl', () {
    test('should add work order to database', () async {
      final workOrder = WorkOrderModel(
        id: 0,
        title: 'Fix AC',
        description: 'Repair air conditioner',
        priority: 'High',
        status: 'Pending',
        dueDate: '2025-07-01',
        technicianId: '1',
        address: 'Jl. Contoh No. 123',
        latitude: -6.2,
        longitude: 106.8,
      );

      final result = await dataSource.addWorkOrder(workOrder);
      expect(result, right(unit));

      final workOrders = await dataSource.getAllWorkOrders();
      // expect(workOrders, isRight); // FIXME: ini perlu di tanyakan lagi
      expect(workOrders.getOrElse((l) => []), hasLength(1));
      expect(workOrders.getOrElse((l) => []).first.title, 'Fix AC');
    });
  });

  test('should create database with work_orders and technicians tables', () async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;

    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    final tableNames = tables.map((table) => table['name']).toList();
    expect(tableNames, contains('work_orders'));
    expect(tableNames, contains('technicians'));
  });
}