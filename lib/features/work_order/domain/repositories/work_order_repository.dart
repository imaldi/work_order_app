import 'package:fpdart/fpdart.dart';
import '../entities/work_order_entity.dart';
import '../entities/technician_entity.dart';

abstract class WorkOrderRepository {
  Future<Either<String, Unit>> addWorkOrder(WorkOrderEntity workOrder);
  Future<Either<String, Unit>> updateWorkOrder(WorkOrderEntity workOrder);
  Future<Either<String, Unit>> deleteWorkOrder(int id);
  Future<Either<String, List<WorkOrderEntity>>> getAllWorkOrders();
  Future<Either<String, Unit>> addTechnician(TechnicianEntity technician);
  Future<Either<String, List<TechnicianEntity>>> getAllTechnicians();
}