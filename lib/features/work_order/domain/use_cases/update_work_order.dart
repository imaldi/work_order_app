import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@injectable
class UpdateWorkOrder {
  final WorkOrderRepository repository;

  UpdateWorkOrder(this.repository);

  Future<Either<String, Unit>> call(WorkOrderEntity workOrder) async {
    return await repository.updateWorkOrder(workOrder);
  }
}