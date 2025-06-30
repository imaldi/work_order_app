// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';

import '../consts_and_enums/enums/sort_by_enum.dart';
import '../errors/failures.dart';


class SearchWorkOrdersParams extends Equatable {
  final String query;

  const SearchWorkOrdersParams({required this.query});
  @override
  List<Object?> get props => [
    query
  ];

  // Opsional: tambah validasi
  Either<Failure, String> validate() {
    if (query.isEmpty) {
      return Left(DatabaseFailure('Search query cannot be empty'));
    }
    return Right(query);
  }
}

class AddWorkOrdersParams extends Equatable {
  final WorkOrderEntity workOrderEntity;

  const AddWorkOrdersParams({required this.workOrderEntity});
  @override
  List<Object?> get props => [
    workOrderEntity
  ];
}

class UpdateWorkOrdersParams extends Equatable {
  final WorkOrderEntity workOrderEntity;

  const UpdateWorkOrdersParams({required this.workOrderEntity});
  @override
  List<Object?> get props => [
    workOrderEntity
  ];
}

class DeleteWorkOrdersParams extends Equatable {
  final int id;

  const DeleteWorkOrdersParams({required this.id});
  @override
  List<Object?> get props => [
    id
  ];
}

class FilterWorkOrderParams extends Equatable {
  final String? status;
  final String? priority;
  final String? technicianId;
  const FilterWorkOrderParams({this.status, this.priority, this.technicianId});

  @override
  List<Object?> get props => [
    status,
    priority,
    technicianId,
  ];
}

class SortWorkOrdersParams extends Equatable {
  final WorkOrderSortField sortBy;
  final bool isAscending;

  const SortWorkOrdersParams({required this.sortBy, required this.isAscending});

  @override
  // TODO: implement props
  List<Object?> get props => [
    sortBy,
    isAscending
  ];
}