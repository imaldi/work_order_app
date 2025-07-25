import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/work_order_group_repository.dart';

@lazySingleton
class DeleteWorkOrderGroup implements UseCase<Unit, QueryIdParams> {
  final WorkOrderGroupRepository repository;

  DeleteWorkOrderGroup(this.repository);

  @override
  Future<Either<Failure, Unit>> call(QueryIdParams params) async {
    return await repository.deleteWorkOrderGroup(params.id);
  }
}