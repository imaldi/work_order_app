import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/work_order_entity.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class GetAllWorkOrders implements UseCase<List<WorkOrderEntity>, NoParams> {
  final WorkOrderRepository repository;

  GetAllWorkOrders(this.repository);

  @override
  Future<Either<Failure, List<WorkOrderEntity>>> call(NoParams params) async {
    return await repository.getAllWorkOrders();
  }
}