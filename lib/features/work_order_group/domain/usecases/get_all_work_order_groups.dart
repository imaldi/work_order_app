import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/features/work_order_group/domain/entity/work_order_group_entity.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/work_order_group_repository.dart';

@lazySingleton
class GetAllWorkOrderGroups implements UseCase<List<WorkOrderGroupEntity>, NoParams> {
  final WorkOrderGroupRepository repository;

  GetAllWorkOrderGroups(this.repository);

  @override
  Future<Either<Failure, List<WorkOrderGroupEntity>>> call(NoParams params) async {
    return await repository.getAllWorkOrderGroups();
  }
}