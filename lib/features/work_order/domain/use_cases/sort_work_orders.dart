import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class SortWorkOrders {
  final WorkOrderRepository repository;
  SortWorkOrders(this.repository);
  Future<Either<String, List<WorkOrderEntity>>> call(WorkOrderSortField sortBy, bool ascending) async {
    return await repository.sortWorkOrders(sortBy, ascending);
  }
}