import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/database_helper.dart';
import '../model/work_order_group_model.dart';
abstract class WorkOrderGroupLocalDataSource {
  Future<Either<Failure, Unit>> createWorkOrderGroup(WorkOrderGroupModel group);
  Future<Either<Failure, WorkOrderGroupModel?>> getWorkOrderGroup(int id);
  Future<Either<Failure, List<WorkOrderGroupModel>>> getAllWorkOrderGroups();
  Future<Either<Failure, Unit>> updateWorkOrderGroup(WorkOrderGroupModel group);
  Future<Either<Failure, Unit>> deleteWorkOrderGroup(int id);
}

@LazySingleton(as: WorkOrderGroupLocalDataSource)
class WorkOrderGroupLocalDataSourceImpl implements WorkOrderGroupLocalDataSource {
  final DatabaseHelper databaseHelper;

  WorkOrderGroupLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<Either<Failure, Unit>> createWorkOrderGroup(WorkOrderGroupModel group) async {
    try {
      final db = await databaseHelper.database;
      await db.insert('work_order_groups', {
        'id': group.id == 0 ? null : group.id, // 0 untuk auto-increment
        'title': group.title,
        'description': group.description,
        'createdAt': group.createdAt,
        'createdBy': group.createdBy,
      });
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to add work order: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkOrderGroupModel?>> getWorkOrderGroup(int id) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(
        'work_order_groups',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) {
        return left(DatabaseFailure('Work order group not found'));
      }
      return right(WorkOrderGroupModel.fromJson(result.first));
    } catch (e) {
      return left(DatabaseFailure('Failed to delete work order group: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkOrderGroupModel>>> getAllWorkOrderGroups() async {
    try {
      final db = await databaseHelper.database;
      final maps = await db.query('work_order_groups');
      final workOrders = maps.map((map) => WorkOrderGroupModel.fromJson(map)).toList();
      return right(workOrders);
    } catch (e) {
      return left(DatabaseFailure('Failed to get work order Groups: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWorkOrderGroup(WorkOrderGroupModel group) async {

    try {
      final db = await databaseHelper.database;
      await db.update('work_order_groups', {
        'id': group.id == 0 ? null : group.id, // 0 untuk auto-increment
        'title': group.title,
        'description': group.description,
        'createdAt': group.createdAt,
        'createdBy': group.createdBy,
      },
        where: 'id = ?',
        whereArgs: [group.id],);
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to add work order: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWorkOrderGroup(int id) async {

    try {
      final db = await databaseHelper.database;
      final result = await db.delete(
        'work_order_groups',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        return left(DatabaseFailure('Work order group not found'));
      }
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to delete work order group: $e'));
    }
  }
}