import 'package:equatable/equatable.dart';

import '../../domain/entity/work_order_group_entity.dart';

import 'package:freezed_annotation/freezed_annotation.dart';


part 'work_order_group_model.freezed.dart';
part 'work_order_group_model.g.dart';

@freezed
abstract class WorkOrderGroupModel with _$WorkOrderGroupModel {
  const factory WorkOrderGroupModel({
    required int id,
    required String title,
    required String description,
    required String createdAt,
    required int createdBy,
  }) = _WorkOrderGroupModel;

  factory WorkOrderGroupModel.fromJson(Map<String, Object?> json) => _$WorkOrderGroupModelFromJson(json);

  const WorkOrderGroupModel._();

  WorkOrderGroupEntity toEntity() => WorkOrderGroupEntity(
    id: id,
    title: title,
    description: description,
    createdAt: createdAt,
    createdBy: createdBy,
  );

  static WorkOrderGroupModel fromEntity(WorkOrderGroupEntity entity) => WorkOrderGroupModel(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    createdAt: entity.createdAt,
    createdBy: entity.createdBy,
  );
}

// class WorkOrderGroupModel extends Equatable {
//   final int? id;
//   final String title;
//   final String description;
//   final String createdAt;
//   final int createdBy;
//
//   const WorkOrderGroupModel({
//     this.id,
//     required this.title,
//     required this.description,
//     required this.createdAt,
//     required this.createdBy,
//   });
//
//   factory WorkOrderGroupModel.fromMap(Map<String, dynamic> map) {
//     return WorkOrderGroupModel(
//       id: map['id'],
//       title: map['title'],
//       description: map['description'],
//       createdAt: map['created_at'],
//       createdBy: map['created_by'],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'created_at': createdAt,
//       'created_by': createdBy,
//     };
//   }
//
//   WorkOrderGroupEntity toEntity() {
//     return WorkOrderGroupEntity(
//       id: id,
//       title: title,
//       description: description,
//       createdAt: createdAt,
//       createdBy: createdBy,
//     );
//   }
//
//   static WorkOrderGroupModel fromEntity(WorkOrderGroupEntity entity) => WorkOrderGroupModel(
//     id: entity.id,
//     title: entity.title,
//     description: entity.description,
//     createdAt: entity.createdAt,
//     createdBy: entity.createdBy,
//   );
//
//   @override
//   List<Object?> get props => [id, title, description, createdAt, createdBy];
// }