import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:work_order_app/core/helpers/database_helper.dart';
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart';
import 'package:work_order_app/features/work_order/data/models/work_order_model.dart';

void main() {
  late DatabaseHelper databaseHelper;
  late WorkOrderLocalDataSourceImpl dataSource;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    TestWidgetsFlutterBinding.ensureInitialized();
    databaseHelper = DatabaseHelper(testDbPath: inMemoryDatabasePath);
    dataSource = WorkOrderLocalDataSourceImpl(databaseHelper);
  });

  tearDownAll(() async {
    final db = await databaseHelper.database;
    await db.close();
  });

  group('WorkOrderLocalDataSourceImpl - Database Operations', () {
    final workOrder = WorkOrderModel(
      id: 1,
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

    testWidgets('should add work order to database', (WidgetTester tester) async {
      final result = await dataSource.addWorkOrder(workOrder);
      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final workOrdersResult = await dataSource.getAllWorkOrders();
      expect(workOrdersResult.isRight(), isTrue);
      expect(workOrdersResult.getOrElse((l) => []), hasLength(1));
      expect(workOrdersResult.getOrElse((l) => []).first.title, 'Fix AC');
    });

    testWidgets('should edit work order in database', (WidgetTester tester) async {
      await dataSource.addWorkOrder(workOrder);
      final updatedWorkOrder = workOrder.copyWith(
        title: 'Fix AC Updated',
        description: 'Repair air conditioner updated',
      );

      final result = await dataSource.updateWorkOrder(updatedWorkOrder);

      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final workOrdersResult = await dataSource.getAllWorkOrders();
      expect(workOrdersResult.isRight(), isTrue);
      expect(workOrdersResult.getOrElse((l) => []), hasLength(1));
      expect(workOrdersResult.getOrElse((l) => []).first.title, 'Fix AC Updated');
    });

    testWidgets('should delete work order from database', (WidgetTester tester) async {
      await dataSource.addWorkOrder(workOrder);

      final result = await dataSource.deleteWorkOrder(workOrder.id);

      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final workOrdersResult = await dataSource.getAllWorkOrders();
      expect(workOrdersResult.isRight(), isTrue);
      expect(workOrdersResult.getOrElse((l) => []), hasLength(0));
    });

    testWidgets('should return error when work order not found for deletion', (WidgetTester tester) async {
      final result = await dataSource.deleteWorkOrder(999);

      expect(result.isLeft(), isTrue);
      expect(result, left('Work order not found'));
    });
  });
}