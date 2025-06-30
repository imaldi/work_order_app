import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/technician_params.dart';
import 'package:work_order_app/features/technician/domain/repository/technician_repository.dart';
import '../../../../core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';

@lazySingleton
class UpdateTechnician implements UseCase<Unit, UpdateTechnicianParams> {
  final TechnicianRepository repository;

  UpdateTechnician(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateTechnicianParams params) async {
    return await repository.updateTechnician(params.technicianEntity);
  }
}