import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@injectable
class AddWorkOrder {
  final WorkOrderRepository repository;

  AddWorkOrder(this.repository);

  Future<Either<String, Unit>> call(WorkOrderEntity workOrder) async {
    return await repository.addWorkOrder(workOrder);
  }
}