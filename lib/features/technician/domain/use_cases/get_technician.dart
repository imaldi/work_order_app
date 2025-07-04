import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/domain/repository/technician_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/technician_entity.dart';

@lazySingleton
class GetTechnician implements UseCase<TechnicianEntity?, QueryIdParams> {
  final TechnicianRepository repository;

  GetTechnician(this.repository);

  @override
  Future<Either<Failure, TechnicianEntity?>> call(QueryIdParams params) async {
    return await repository.getTechnician(params.id);
  }
}