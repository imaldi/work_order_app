import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/features/technician/domain/repository/technician_repository.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';

@lazySingleton
class GetAllTechnicians implements UseCase<List<TechnicianEntity>, NoParams> {
  final TechnicianRepository repository;

  GetAllTechnicians(this.repository);

  @override
  Future<Either<Failure, List<TechnicianEntity>>> call(NoParams params) async {
    return await repository.getAllTechnicians();
  }
}