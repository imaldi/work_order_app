import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class GetAllWorkOrders {
  final WorkOrderRepository repository;

  GetAllWorkOrders(this.repository);

  Future<Either<Failure, List<WorkOrderEntity>>> call() async {
    return await repository.getAllWorkOrders();
  }
}