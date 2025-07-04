import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entity/technician_entity.dart';
import '../../../technician/data/model/technician_model.dart';
import '../../domain/repository/technician_repository.dart';
import '../data_sources/technician_local_data_source.dart';

@LazySingleton(as: TechnicianRepository)
class TechnicianRepositoryImpl implements TechnicianRepository {
  final TechnicianLocalDataSource localDataSource;

  TechnicianRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Unit>> addTechnician(TechnicianEntity technician) async {
    return await localDataSource.addTechnician(TechnicianModel.fromEntity(technician));
  }

  @override
  Future<Either<Failure, Unit>> updateTechnician(TechnicianEntity technician) async {
    return await localDataSource.updateTechnician(TechnicianModel.fromEntity(technician));
  }

  @override
  Future<Either<Failure, Unit>> deleteTechnician(int id) async {
    return await localDataSource.deleteTechnician(id);
  }

  @override
  Future<Either<Failure, List<TechnicianEntity>>> getAllTechnicians() async {
    final either = await localDataSource.getAllTechnicians();
    return either.map((technicians) => technicians.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, TechnicianEntity?>> getTechnician(int id) async {
    final either = await localDataSource.getTechnician(id);
    return either.map((result) => result?.toEntity());
  }
}