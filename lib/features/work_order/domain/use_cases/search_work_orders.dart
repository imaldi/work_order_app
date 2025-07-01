import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order_entity.dart';
import '../repository/work_order_repository.dart';

@lazySingleton
class SearchWorkOrders implements UseCase<List<WorkOrderEntity>, SearchWorkOrdersParams> {
  final WorkOrderRepository repository;
  SearchWorkOrders(this.repository);

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> call(SearchWorkOrdersParams params) async {
     return await repository.searchWorkOrders(params.query);
  }
}