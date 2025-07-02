import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entity/work_order_group_entity.dart';

abstract class WorkOrderGroupRepository {
  Future<Either<Failure, Unit>> createWorkOrderGroup(WorkOrderGroupEntity group);
  Future<Either<Failure, WorkOrderGroupEntity?>> getWorkOrderGroup(int id);
  Future<Either<Failure, List<WorkOrderGroupEntity>>> getAllWorkOrderGroups();
  Future<Either<Failure, Unit>> updateWorkOrderGroup(WorkOrderGroupEntity group);
  Future<Either<Failure, Unit>> deleteWorkOrderGroup(int id);
}