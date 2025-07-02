// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../features/work_order_group/domain/entity/work_order_group_entity.dart';
import '../errors/failures.dart';


class SearchWorkOrderGroupsParams extends Equatable {
  final String query;

  const SearchWorkOrderGroupsParams({required this.query});
  @override
  List<Object?> get props => [
    query
  ];

  // Opsional: tambah validasi; tidak terpakai karena search nya per user interaction
  Either<Failure, String> validate() {
    if (query.isEmpty) {
      return Left(DatabaseFailure('Search query cannot be empty'));
    }
    return Right(query);
  }
}

class AddWorkOrderGroupsParams extends Equatable {
  final WorkOrderGroupEntity workOrderGroupEntity;

  const AddWorkOrderGroupsParams({required this.workOrderGroupEntity});
  @override
  List<Object?> get props => [
    workOrderGroupEntity
  ];
}

class UpdateWorkOrderGroupsParams extends Equatable {
  final WorkOrderGroupEntity workOrderGroupEntity;

  const UpdateWorkOrderGroupsParams({required this.workOrderGroupEntity});
  @override
  List<Object?> get props => [
    WorkOrderGroupEntity
  ];
}

class DeleteWorkOrderGroupsParams extends Equatable {
  final int id;

  const DeleteWorkOrderGroupsParams({required this.id});
  @override
  List<Object?> get props => [
    id
  ];
}
