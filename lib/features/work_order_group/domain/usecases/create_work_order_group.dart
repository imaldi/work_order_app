import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/work_order_group_params.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../work_order/data/model/work_order_model.dart';
import '../../../work_order/domain/repository/work_order_repository.dart';

@lazySingleton
class CreateWorkOrderGroup implements UseCase<Unit, CreateEntityParams<WorkOrderEntity>> {
  final WorkOrderRepository repository;

  CreateWorkOrderGroup(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateEntityParams<WorkOrderEntity> params) async {
    return await repository.addWorkOrder(params.entity);
  }
}