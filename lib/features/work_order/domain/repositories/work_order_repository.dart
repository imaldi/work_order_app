import 'package:fpdart/fpdart.dart';
import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../../../../core/params/params.dart';
import '../entities/work_order_entity.dart';
import '../entities/technician_entity.dart';

abstract class WorkOrderRepository {
  Future<Either<String, Unit>> addWorkOrder(WorkOrderEntity workOrder);
  Future<Either<String, Unit>> updateWorkOrder(WorkOrderEntity workOrder);
  Future<Either<String, Unit>> deleteWorkOrder(int id);
  Future<Either<String, List<WorkOrderEntity>>> getAllWorkOrders();
  Future<Either<String, Unit>> addTechnician(TechnicianEntity technician);
  Future<Either<String, List<TechnicianEntity>>> getAllTechnicians();
  Future<Either<String, List<WorkOrderEntity>>> searchWorkOrders(String query);
  Future<Either<String, List<WorkOrderEntity>>> filterWorkOrders(FilterParams params);
  Future<Either<String, List<WorkOrderEntity>>> sortWorkOrders(WorkOrderSortField sortBy, bool ascending);
}