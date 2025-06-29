import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/work_order_repository.dart';

@lazySingleton
class DeleteWorkOrder {
  final WorkOrderRepository repository;

  DeleteWorkOrder(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteWorkOrder(id);
  }
}