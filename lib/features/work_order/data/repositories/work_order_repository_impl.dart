import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/work_order_entity.dart';
import '../../domain/entities/technician_entity.dart';
import '../../domain/repositories/work_order_repository.dart';
import '../data_sources/work_order_local_data_source.dart';
import '../models/work_order_model.dart';
import '../models/technician_model.dart';

@LazySingleton(as: WorkOrderRepository)
class WorkOrderRepositoryImpl implements WorkOrderRepository {
  final WorkOrderLocalDataSource localDataSource;

  WorkOrderRepositoryImpl(this.localDataSource);

  @override
  Future<Either<String, Unit>> addWorkOrder(WorkOrderEntity workOrder) async {
    return await localDataSource.addWorkOrder(WorkOrderModel.fromEntity(workOrder));
  }

  @override
  Future<Either<String, Unit>> updateWorkOrder(WorkOrderEntity workOrder) async {
    return await localDataSource.updateWorkOrder(WorkOrderModel.fromEntity(workOrder));
  }

  @override
  Future<Either<String, Unit>> deleteWorkOrder(int id) async {
    return await localDataSource.deleteWorkOrder(id);
  }

  @override
  Future<Either<String, List<WorkOrderEntity>>> getAllWorkOrders() async {
    final either = await localDataSource.getAllWorkOrders();
    return either.map((workOrders) => workOrders.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<String, Unit>> addTechnician(TechnicianEntity technician) async {
    return await localDataSource.addTechnician(TechnicianModel.fromEntity(technician));
  }

  @override
  Future<Either<String, List<TechnicianEntity>>> getAllTechnicians() async {
    final either = await localDataSource.getAllTechnicians();
    return either.map((technicians) => technicians.map((model) => model.toEntity()).toList());
  }
}