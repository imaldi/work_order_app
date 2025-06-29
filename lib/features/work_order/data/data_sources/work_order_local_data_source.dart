import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../models/work_order_model.dart';
import '../models/technician_model.dart';
import '../../../../core/helpers/database_helper.dart';

abstract class WorkOrderLocalDataSource {
  Future<Either<DatabaseFailure, Unit>> addWorkOrder(WorkOrderModel workOrder);
  Future<Either<DatabaseFailure, Unit>> updateWorkOrder(WorkOrderModel workOrder);
  Future<Either<DatabaseFailure, Unit>> deleteWorkOrder(int id);
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> getAllWorkOrders();
  Future<Either<DatabaseFailure, Unit>> addTechnician(TechnicianModel technician);
  Future<Either<DatabaseFailure, List<TechnicianModel>>> getAllTechnicians();
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> searchWorkOrders(String query);
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> filterWorkOrders(FilterWorkOrderParams params);
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> sortWorkOrders(WorkOrderSortField sortBy, bool ascending);
}

@LazySingleton(as: WorkOrderLocalDataSource)
class WorkOrderLocalDataSourceImpl implements WorkOrderLocalDataSource {
  final DatabaseHelper databaseHelper;

  WorkOrderLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<Either<DatabaseFailure, Unit>> addWorkOrder(WorkOrderModel workOrder) async {
    try {
      final db = await databaseHelper.database;
      await db.insert('work_orders', {
        'id': workOrder.id == 0 ? null : workOrder.id, // 0 untuk auto-increment
        'title': workOrder.title,
        'description': workOrder.description,
        'priority': workOrder.priority,
        'status': workOrder.status,
        'dueDate': workOrder.dueDate,
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
  Future<Either<DatabaseFailure, Unit>> updateWorkOrder(WorkOrderModel workOrder) async {
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
  Future<Either<DatabaseFailure, Unit>> deleteWorkOrder(int id) async {
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
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> getAllWorkOrders() async {
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
  Future<Either<DatabaseFailure, Unit>> addTechnician(TechnicianModel technician) async {
    try {
      final db = await databaseHelper.database;
      await db.insert('technicians', {
        'id': technician.id == 0 ? null : technician.id, // 0 untuk auto-increment
        'name': technician.name,
        'contact': technician.contact,
      });
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to add technician: $e'));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TechnicianModel>>> getAllTechnicians() async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query('technicians');
      final technicians = maps.map((map) => TechnicianModel.fromJson(map)).toList();
      return right(technicians);
    } catch (e) {
      return left(DatabaseFailure('Failed to get technicians: $e'));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> searchWorkOrders(String query) async {
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
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> filterWorkOrders(FilterWorkOrderParams params) async {
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
  Future<Either<DatabaseFailure, List<WorkOrderModel>>> sortWorkOrders(WorkOrderSortField sortBy, bool ascending) async {
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