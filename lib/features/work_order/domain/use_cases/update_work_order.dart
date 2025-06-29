import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class UpdateWorkOrder implements UseCase<Unit, UpdateWorkOrdersParams> {
  final WorkOrderRepository repository;

  UpdateWorkOrder(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateWorkOrdersParams params) async {
    return await repository.updateWorkOrder(params.workOrderEntity);
  }
}