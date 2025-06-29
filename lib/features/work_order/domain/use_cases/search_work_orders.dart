import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class SearchWorkOrders {
  final WorkOrderRepository repository;
  SearchWorkOrders(this.repository);
  Future<Either<String, List<WorkOrderEntity>>> call(String query) async {
    return await repository.searchWorkOrders(query);
  }
}