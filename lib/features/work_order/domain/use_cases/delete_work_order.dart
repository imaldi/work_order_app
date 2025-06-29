import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../repositories/work_order_repository.dart';

@injectable
class DeleteWorkOrder {
  final WorkOrderRepository repository;

  DeleteWorkOrder(this.repository);

  Future<Either<String, Unit>> call(int id) async {
    return await repository.deleteWorkOrder(id);
  }
}