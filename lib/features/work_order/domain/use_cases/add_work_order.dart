import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class AddWorkOrder implements UseCase<Unit, AddWorkOrdersParams> {
  final WorkOrderRepository repository;

  AddWorkOrder(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddWorkOrdersParams params) async {
    return await repository.addWorkOrder(params.workOrderEntity);
  }
}