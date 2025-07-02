import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/features/work_order_group/domain/entity/work_order_group_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repository/work_order_group_repository.dart';
import '../data_sources/work_order_group_local_data_source.dart';
import '../model/work_order_group_model.dart';

@LazySingleton(as: WorkOrderGroupRepository)
class WorkOrderGroupRepositoryImpl implements WorkOrderGroupRepository {
  final WorkOrderGroupLocalDataSource localDataSource;

  WorkOrderGroupRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Unit>>  createWorkOrderGroup(WorkOrderGroupEntity group) async {
    return await localDataSource.createWorkOrderGroup(WorkOrderGroupModel.fromEntity(group));
  }

  @override
  Future<Either<Failure, WorkOrderGroupEntity?>> getWorkOrderGroup(int id) async {
    final either = await localDataSource.getWorkOrderGroup(id);
    return either.map((result) => result?.toEntity());
  }

  @override
  Future<Either<Failure, List<WorkOrderGroupEntity>>> getAllWorkOrderGroups() async {
    final either = await localDataSource.getAllWorkOrderGroups();
    return either.map((groups) => groups.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, Unit>>  updateWorkOrderGroup(WorkOrderGroupEntity group) async {
    return await localDataSource.updateWorkOrderGroup(WorkOrderGroupModel.fromEntity(group));
  }

  @override
  Future<Either<Failure, Unit>> deleteWorkOrderGroup(int id) async {
    return await localDataSource.deleteWorkOrderGroup(id);
  }
}