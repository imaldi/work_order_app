import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/work_order_params.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/work_order_entity.dart';
import '../repository/work_order_repository.dart';

@lazySingleton
class FilterWorkOrders implements UseCase<List<WorkOrderEntity>, FilterWorkOrderParams> {
  final WorkOrderRepository repository;
  FilterWorkOrders(this.repository);
  @override
  Future<Either<Failure, List<WorkOrderEntity>>> call(FilterWorkOrderParams params) async {
    return await repository.filterWorkOrders(params);
  }
}