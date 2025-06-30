import 'package:equatable/equatable.dart';

import '../../features/technician/domain/entity/technician_entity.dart';

class AddTechnicianParams extends Equatable {
  final TechnicianEntity technicianEntity;

  const AddTechnicianParams({required this.technicianEntity});
  @override
  List<Object?> get props => [
    technicianEntity
  ];
}

class UpdateTechnicianParams extends Equatable {
  final TechnicianEntity technicianEntity;

  const UpdateTechnicianParams({required this.technicianEntity});
  @override
  List<Object?> get props => [
    technicianEntity
  ];
}

class DeleteTechnicianParams extends Equatable {
  final int id;

  const DeleteTechnicianParams({required this.id});
  @override
  List<Object?> get props => [
    id
  ];
}