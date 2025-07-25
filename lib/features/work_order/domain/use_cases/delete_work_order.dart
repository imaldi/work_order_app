import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/params/work_order_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/work_order_repository.dart';

@lazySingleton
class DeleteWorkOrder implements UseCase<Unit, QueryIdParams> {
  final WorkOrderRepository repository;

  DeleteWorkOrder(this.repository);

  @override
  Future<Either<Failure, Unit>> call(QueryIdParams params) async {
    return await repository.deleteWorkOrder(params.id);
  }
}