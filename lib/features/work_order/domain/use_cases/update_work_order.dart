import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class UpdateWorkOrder {
  final WorkOrderRepository repository;

  UpdateWorkOrder(this.repository);

  Future<Either<Failure, Unit>> call(WorkOrderEntity workOrder) async {
    return await repository.updateWorkOrder(workOrder);
  }
}