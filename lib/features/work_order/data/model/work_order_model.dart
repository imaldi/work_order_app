import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/work_order_entity.dart';

part 'work_order_model.freezed.dart';
part 'work_order_model.g.dart';

@freezed
abstract class WorkOrderModel with _$WorkOrderModel {
  const factory WorkOrderModel({
    required int id,
    required String title,
    required String customId,
    required String materials,
    required String photoPath,
    required String attachmentPath,
    required String description,
    required String priority,
    required String status,
    required String dueDate,
    required String scheduledStart,
    required String scheduledEnd,
    required String createdAt,
    required int technicianId,
    required int groupId,
    required String address,
    required String location,
    required double latitude,
    required double longitude,
  }) = _WorkOrderModel;

  factory WorkOrderModel.fromJson(Map<String, Object?> json) => _$WorkOrderModelFromJson(json);

  const WorkOrderModel._();

  WorkOrderEntity toEntity() => WorkOrderEntity(
    id: id,
    customId: customId,
    title: title,
    description: description,
    materials: materials,
    location: location,
    photoPath: photoPath,
    attachmentPath: attachmentPath,
    priority: priority,
    status: status,
    dueDate: dueDate,
    scheduledStart: scheduledStart,
    scheduledEnd: scheduledEnd,
    createdAt: createdAt,
    technicianId: technicianId,
    groupId: groupId,
    address: address,
    latitude: latitude,
    longitude: longitude,
  );

  static WorkOrderModel fromEntity(WorkOrderEntity entity) => WorkOrderModel(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    priority: entity.priority,
    status: entity.status,
    dueDate: entity.dueDate,
    createdAt: entity.createdAt,
    technicianId: entity.technicianId,
    groupId: entity.groupId,
    address: entity.address,
    latitude: entity.latitude,
    longitude: entity.longitude,
    customId: entity.customId,
    materials: entity.materials,
    photoPath: entity.photoPath,
    attachmentPath: entity.attachmentPath,
    scheduledStart: entity.scheduledStart,
    scheduledEnd: entity.scheduledEnd,
    location: entity.location,
  );
}