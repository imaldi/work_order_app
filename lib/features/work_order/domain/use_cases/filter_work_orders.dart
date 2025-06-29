import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/params.dart';

import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class FilterWorkOrders {
  final WorkOrderRepository repository;
  FilterWorkOrders(this.repository);
  Future<Either<Failure, List<WorkOrderEntity>>> call(FilterWorkOrderParams params) async {
    return await repository.filterWorkOrders(params);
  }
}