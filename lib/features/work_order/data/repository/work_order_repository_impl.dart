import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import '../../../../core/consts_and_enums/enums/sort_by_enum.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/work_order_entity.dart';
import '../../../technician/domain/entity/technician_entity.dart';
import '../../domain/repository/work_order_repository.dart';
import '../data_sources/work_order_local_data_source.dart';
import '../model/work_order_model.dart';
import '../../../technician/data/model/technician_model.dart';

@LazySingleton(as: WorkOrderRepository)
class WorkOrderRepositoryImpl implements WorkOrderRepository {
  final WorkOrderLocalDataSource localDataSource;

  WorkOrderRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Unit>> addWorkOrder(WorkOrderEntity workOrder) async {
    return await localDataSource.addWorkOrder(WorkOrderModel.fromEntity(workOrder));
  }

  @override
  Future<Either<Failure, Unit>> updateWorkOrder(WorkOrderEntity workOrder) async {
    return await localDataSource.updateWorkOrder(WorkOrderModel.fromEntity(workOrder));
  }

  @override
  Future<Either<Failure, Unit>> deleteWorkOrder(int id) async {
    return await localDataSource.deleteWorkOrder(id);
  }

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> getAllWorkOrders() async {
    final either = await localDataSource.getAllWorkOrders();
    return either.map((workOrders) => workOrders.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> filterWorkOrders(FilterWorkOrderParams params) async {
    final either = await localDataSource.filterWorkOrders(params);
    return either.map((technicians) => technicians.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> searchWorkOrders(String query) async {
    final either = await localDataSource.searchWorkOrders(query);
    return either.map((technicians) => technicians.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> sortWorkOrders(WorkOrderSortField sortBy, bool ascending) async {
    final either = await localDataSource.sortWorkOrders(sortBy, ascending);
    return either.map((technicians) => technicians.map((model) => model.toEntity()).toList());
  }
}