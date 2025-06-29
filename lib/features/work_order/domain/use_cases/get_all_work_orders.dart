import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@injectable
class GetAllWorkOrders {
  final WorkOrderRepository repository;

  GetAllWorkOrders(this.repository);

  Future<Either<String, List<WorkOrderEntity>>> call() async {
    return await repository.getAllWorkOrders();
  }
}