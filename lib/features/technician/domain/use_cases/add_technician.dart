import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/technician_params.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/technician_repository.dart';

@lazySingleton
class AddTechnician implements UseCase<Unit, AddTechnicianParams> {
  final TechnicianRepository repository;

  AddTechnician(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddTechnicianParams params) async {
    return await repository.addTechnician(params.technicianEntity);
  }
}