import 'package:equatable/equatable.dart';

class WorkOrderGroupEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String createdAt;
  final int createdBy;

  WorkOrderGroupEntity({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [id, title, description, createdAt, createdBy];
}