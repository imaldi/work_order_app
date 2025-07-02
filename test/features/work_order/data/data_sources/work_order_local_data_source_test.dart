import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/helpers/database_helper.dart';
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart';
import 'package:work_order_app/features/work_order/data/model/work_order_model.dart';

void main() {
  late DatabaseHelper databaseHelper;
  late WorkOrderLocalDataSourceImpl dataSource;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    TestWidgetsFlutterBinding.ensureInitialized();
    databaseHelper = DatabaseHelper();
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
      dueDate: '2025-07-01 00:00',
      createdAt: '2025-06-01 00:00',
      technicianId: 1,
      address: 'Jl. Contoh No. 123',
      latitude: -6.2,
      longitude: 106.8,
    );

    test('should add work order to database', () async {
      final result = await dataSource.addWorkOrder(workOrder);
      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final workOrdersResult = await dataSource.getAllWorkOrders();
      expect(workOrdersResult.isRight(), isTrue);
      expect(workOrdersResult.getOrElse((l) => []), hasLength(1));
      expect(workOrdersResult.getOrElse((l) => []).first.title, 'Fix AC');
    });

    test('should edit work order in database', () async {
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

    test('should delete work order from database', () async {
      await dataSource.addWorkOrder(workOrder);

      final result = await dataSource.deleteWorkOrder(workOrder.id);

      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final workOrdersResult = await dataSource.getAllWorkOrders();
      expect(workOrdersResult.isRight(), isTrue);
      expect(workOrdersResult.getOrElse((l) => []), hasLength(0));
    });

    test('should return error when work order not found for deletion', () async {
      final result = await dataSource.deleteWorkOrder(999);

      expect(result.isLeft(), isTrue);
      result.fold(
            (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect(failure.message, 'Work order not found');
        },
            (unit) => fail('Expected Left, but got Right'),
      );
    });

    //   Pertimbangkan menambahkan test case untuk skenario lain, seperti:
    //
    //     Menambahkan WorkOrderModel dengan field null (jika diperbolehkan).
    //     Mengedit WorkOrderModel yang tidak ada (harus return Left dengan pesan error).
    //     Mengambil getAllWorkOrders saat database kosong (harus return Right dengan list kosong).

    //     contoh edge cases
    test('should return empty list when no work orders exist', () async {
      final workOrdersResult = await dataSource.getAllWorkOrders();
      expect(workOrdersResult.isRight(), isTrue);
      expect(workOrdersResult.getOrElse((l) => []), isEmpty);
    });
  });

}