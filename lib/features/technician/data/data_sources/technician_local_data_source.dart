import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../technician/data/model/technician_model.dart';
import '../../../../core/helpers/database_helper.dart';

abstract class TechnicianLocalDataSource {
  Future<Either<Failure, Unit>> addTechnician(TechnicianModel technician);
  Future<Either<Failure, Unit>> updateTechnician(TechnicianModel technician);
  Future<Either<Failure, Unit>> deleteTechnician(int id);
  Future<Either<Failure, TechnicianModel?>> getTechnician(int id);
  Future<Either<Failure, List<TechnicianModel>>> getAllTechnicians();
}

@LazySingleton(as: TechnicianLocalDataSource)
class TechnicianLocalDataSourceImpl implements TechnicianLocalDataSource {
  final DatabaseHelper databaseHelper;

  TechnicianLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<Either<Failure, Unit>> updateTechnician(TechnicianModel technician) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        'technicians',
        {
          'name': technician.name,
          'contact': technician.contact,
        },
        where: 'id = ?',
        whereArgs: [technician.id],
      );
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to update work order: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTechnician(int id) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.delete(
        'technicians',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        return left(DatabaseFailure('Technician not found'));
      }
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure('Failed to delete work order: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTechnician(TechnicianModel technician) async {
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
  Future<Either<Failure, List<TechnicianModel>>> getAllTechnicians() async {
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
  Future<Either<Failure, TechnicianModel?>> getTechnician(int id) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(
        'technicians',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) {
        return left(DatabaseFailure('Technician not found'));
      }
      return right(TechnicianModel.fromJson(result.first));
    } catch (e) {
      return left(DatabaseFailure('Failed to get technician: $e'));
    }
  }
}