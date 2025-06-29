// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
import 'package:equatable/equatable.dart';

import '../consts_and_enums/enums/sort_by_enum.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
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

class SortWorkOrdersParams extends Equatable{
  final WorkOrderSortField sortBy;
  final bool ascending;

  const SortWorkOrdersParams(this.sortBy, this.ascending);

  @override
  // TODO: implement props
  List<Object?> get props => [
    sortBy,
    ascending
  ];
}