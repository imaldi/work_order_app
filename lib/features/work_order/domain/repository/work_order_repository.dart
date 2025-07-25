import 'package:fpdart/fpdart.dart';
import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/work_order_params.dart';
import '../entities/work_order_entity.dart';

abstract class WorkOrderRepository {
  Future<Either<Failure, Unit>> addWorkOrder(WorkOrderEntity workOrder);
  Future<Either<Failure, Unit>> updateWorkOrder(WorkOrderEntity workOrder);
  Future<Either<Failure, Unit>> deleteWorkOrder(int id);
  Future<Either<Failure, List<WorkOrderEntity>>> getAllWorkOrders();
  Future<Either<Failure, List<WorkOrderEntity>>> searchWorkOrders(String query);
  Future<Either<Failure, List<WorkOrderEntity>>> filterWorkOrders(FilterWorkOrderParams params);
  Future<Either<Failure, List<WorkOrderEntity>>> sortWorkOrders(WorkOrderSortFieldBy sortBy, bool ascending);
}