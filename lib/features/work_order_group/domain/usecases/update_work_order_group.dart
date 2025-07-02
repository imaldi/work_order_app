import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/features/work_order_group/domain/entity/work_order_group_entity.dart';
import '../../../../core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/work_order_group_repository.dart';

@lazySingleton
class UpdateWorkOrderGroup implements UseCase<Unit, CreateEntityParams<WorkOrderGroupEntity>> {
  final WorkOrderGroupRepository repository;

  UpdateWorkOrderGroup(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateEntityParams<WorkOrderGroupEntity> params) async {
    return await repository.updateWorkOrderGroup(params.entity);
  }
}