import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/params/technician_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/technician_repository.dart';

@lazySingleton
class DeleteTechnician implements UseCase<Unit, DeleteTechnicianParams> {
  final TechnicianRepository repository;

  DeleteTechnician(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteTechnicianParams params) async {
    return await repository.deleteTechnician(params.id);
  }
}