import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import '../models/work_order_model.dart';
import '../models/technician_model.dart';
import '../../../../core/helpers/database_helper.dart';

abstract class WorkOrderLocalDataSource {
  Future<Either<String, Unit>> addWorkOrder(WorkOrderModel workOrder);
  Future<Either<String, Unit>> updateWorkOrder(WorkOrderModel workOrder);
  Future<Either<String, Unit>> deleteWorkOrder(int id);
  Future<Either<String, List<WorkOrderModel>>> getAllWorkOrders();
  Future<Either<String, Unit>> addTechnician(TechnicianModel technician);
  Future<Either<String, List<TechnicianModel>>> getAllTechnicians();
}

class WorkOrderLocalDataSourceImpl implements WorkOrderLocalDataSource {
  final DatabaseHelper databaseHelper;

  WorkOrderLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<Either<String, Unit>> addWorkOrder(WorkOrderModel workOrder) async {
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
      return left('Failed to add work order: $e');
    }
  }

  @override
  Future<Either<String, Unit>> updateWorkOrder(WorkOrderModel workOrder) async {
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
      return left('Failed to update work order: $e');
    }
  }

  @override
  Future<Either<String, Unit>> deleteWorkOrder(int id) async {
    try {
      final db = await databaseHelper.database;
      await db.delete('work_orders', where: 'id = ?', whereArgs: [id]);
      return right(unit);
    } catch (e) {
      return left('Failed to delete work order: $e');
    }
  }

  @override
  Future<Either<String, List<WorkOrderModel>>> getAllWorkOrders() async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query('work_orders');
      final workOrders = maps.map((map) => WorkOrderModel.fromJson(map)).toList();
      return right(workOrders);
    } catch (e) {
      return left('Failed to get work orders: $e');
    }
  }

  @override
  Future<Either<String, Unit>> addTechnician(TechnicianModel technician) async {
    try {
      final db = await databaseHelper.database;
      await db.insert('technicians', {
        'id': technician.id == 0 ? null : technician.id, // 0 untuk auto-increment
        'name': technician.name,
        'contact': technician.contact,
      });
      return right(unit);
    } catch (e) {
      return left('Failed to add technician: $e');
    }
  }

  @override
  Future<Either<String, List<TechnicianModel>>> getAllTechnicians() async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query('technicians');
      final technicians = maps.map((map) => TechnicianModel.fromJson(map)).toList();
      return right(technicians);
    } catch (e) {
      return left('Failed to get technicians: $e');
    }
  }
}