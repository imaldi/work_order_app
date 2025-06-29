import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class SortWorkOrders implements UseCase<List<WorkOrderEntity>, SortWorkOrdersParams>{
  final WorkOrderRepository repository;
  SortWorkOrders(this.repository);

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> call(SortWorkOrdersParams params) async {
    return await repository.sortWorkOrders(params.sortBy, params.ascending);
  }
}