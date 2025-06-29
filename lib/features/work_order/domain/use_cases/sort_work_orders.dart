import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class SortWorkOrders {
  final WorkOrderRepository repository;
  SortWorkOrders(this.repository);
  Future<Either<String, List<WorkOrderEntity>>> call(String sortBy, bool ascending) async {
    return await repository.sortWorkOrders(sortBy, ascending);
  }
}