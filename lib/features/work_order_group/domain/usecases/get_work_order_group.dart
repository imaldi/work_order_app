import 'package:fpdart/fpdart.dart';
import 'package:work_order_app/core/params/work_order_params.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/work_order_group_entity.dart';
import '../repository/work_order_group_repository.dart';

class GetWorkOrderGroup implements UseCase<WorkOrderGroupEntity?, QueryIdParams> {
  final WorkOrderGroupRepository repository;

  GetWorkOrderGroup(this.repository);

  @override
  Future<Either<Failure, WorkOrderGroupEntity?>> call(QueryIdParams params) async {
    return await repository.getWorkOrderGroup(params.id);
  }
}