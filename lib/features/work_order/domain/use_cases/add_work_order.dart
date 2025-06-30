import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/work_order_repository.dart';

@lazySingleton
class AddWorkOrder implements UseCase<Unit, AddWorkOrdersParams> {
  final WorkOrderRepository repository;

  AddWorkOrder(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddWorkOrdersParams params) async {
    return await repository.addWorkOrder(params.workOrderEntity);
  }
}