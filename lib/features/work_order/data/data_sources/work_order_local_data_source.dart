import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/work_order_params.dart';
import '../model/work_order_model.dart';
import '../../../../core/helpers/database_helper.dart';

abstract class WorkOrderLocalDataSource {
  Future<Either<Failure, Unit>> addWorkOrder(WorkOrderModel workOrder);
  Future<Either<Failure, Unit>> updateWorkOrder(WorkOrderModel workOrder);
  Future<Either<Failure, Unit>> deleteWorkOrder(int id);
  Future<Either<Failure, List<WorkOrderModel>>> getAllWorkOrders();
  Future<Either<Failure, List<WorkOrderModel>>> searchWorkOrders(String query);
  Future<Either<Failure, List<WorkOrderModel>>> filterWorkOrders(FilterWorkOrderParams params);
  Future<Either<Failure, List<WorkOrderModel>>> sortWorkOrders(WorkOrderSortFieldBy sortBy, bool ascending);
}

@LazySingleton(as: WorkOrderLocalDataSource)
class WorkOrderLocalDataSourceImpl implements WorkOrderLocalDataSource {
  final DatabaseHelper databaseHelper;

  WorkOrderLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<Either<Failure, Unit>> addWorkOrder(WorkOrderModel workOrder) async {
    try {
      final db = await databaseHelper.database;
      await db.insert('work_orders', {
        'id': workOrder.id == 0 ? null : workOrder.id, // 0 untuk auto-increment
        'title': workOrder.title,
        'description': workOrder.description,
        'priority': workOrder.priority,
        'status': workOrder.status,
        'dueDate': workOrder.dueDate,
        'createdAt': workOrder.createdAt,
        'technicianId': workOrder.technicianId,
        'address': workOrder.address,
        'latitude': workOrder.latitude,
        'longitude': workOrder.longitude,
      });
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to add work order: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWorkOrder(WorkOrderModel workOrder) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        'work_orders',
        {
          'title': workOrder.title,
          'description': workOrder.description,
          'priority': workOrder.priority,
          'status': workOrder.status,
          'dueDate': workOrder.dueDate,
          'createdAt': workOrder.createdAt,
          'technicianId': workOrder.technicianId,
          'address': workOrder.address,
          'latitude': workOrder.latitude,
          'longitude': workOrder.longitude,
        },
        where: 'id = ?',
        whereArgs: [workOrder.id],
      );
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to update work order: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWorkOrder(int id) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.delete(
        'work_orders',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        return left(DatabaseFailure('Work order not found'));
      }
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to delete work order: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkOrderModel>>> getAllWorkOrders() async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query('work_orders');
      final workOrders = maps.map((map) => WorkOrderModel.fromJson(map)).toList();
      return right(workOrders);
    } catch (e) {
      return left(DatabaseFailure('Failed to get work orders: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkOrderModel>>> searchWorkOrders(String query) async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query(
        'work_orders',
        where: 'title LIKE ? OR description LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
      );
      return right(maps.map((map) => WorkOrderModel.fromJson(map)).toList());
    } catch (e) {
      return left(DatabaseFailure('Failed to search work orders: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkOrderModel>>> filterWorkOrders(FilterWorkOrderParams params) async {
    try {
      final db = await databaseHelper.database;
      final conditions = <String>[];
      final args = <dynamic>[];
      if (params.status != null) {
        conditions.add('status = ?');
        args.add(params.status);
      }
      if (params.priority != null) {
        conditions.add('priority = ?');
        args.add(params.priority);
      }
      if (params.technicianId != null) {
        conditions.add('technicianId = ?');
        args.add(params.technicianId);
      }

      // Filter berdasarkan dateRange
      if (params.dateRange != null) {
        // Asumsi kolom createdAt disimpan sebagai TEXT dalam format ISO 8601
        conditions.add('dueDate BETWEEN ? AND ?');
        // Konversi DateTime ke string ISO 8601 untuk SQLite
        args.add(params.dateRange!.start.toIso8601String());
        // Tambahkan 23:59:59.999 ke end date agar mencakup seluruh hari
        final endDate = params.dateRange!.end.add(Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999));
        args.add(endDate.toIso8601String());
      }

      final where = conditions.isEmpty ? null : conditions.join(' AND ');
      final maps = await db.query(
        'work_orders',
        where: where,
        whereArgs: args.isEmpty ? null : args,
      );
      return right(maps.map((map) => WorkOrderModel.fromJson(map)).toList());
    } catch (e) {
      return left(DatabaseFailure('Failed to filter work orders: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkOrderModel>>> sortWorkOrders(WorkOrderSortFieldBy sortBy, bool ascending) async {
    try {
      final db = await databaseHelper.database;
      final orderBy = '${sortBy.value} ${ascending ? 'ASC' : 'DESC'}';
      final maps = await db.query('work_orders', orderBy: orderBy);
      return right(maps.map((map) => WorkOrderModel.fromJson(map)).toList());
    } catch (e) {
      return left(DatabaseFailure('Failed to sort work orders: $e'));
    }
  }
}