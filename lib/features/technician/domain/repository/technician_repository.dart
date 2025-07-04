import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entity/technician_entity.dart';

abstract class TechnicianRepository {
  Future<Either<Failure, Unit>> addTechnician(TechnicianEntity technician);
  Future<Either<Failure, Unit>> updateTechnician(TechnicianEntity technician);
  Future<Either<Failure, Unit>> deleteTechnician(int id);
  Future<Either<Failure, TechnicianEntity?>> getTechnician(int id);
  Future<Either<Failure, List<TechnicianEntity>>> getAllTechnicians();
}