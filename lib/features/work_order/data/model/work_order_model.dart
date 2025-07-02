import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/work_order_entity.dart';

part 'work_order_model.freezed.dart';
part 'work_order_model.g.dart';

@freezed
abstract class WorkOrderModel with _$WorkOrderModel {
  const factory WorkOrderModel({
    required int id,
    required String title,
    required String description,
    required String priority,
    required String status,
    required String dueDate,
    required String createdAt,
    required int technicianId,
    required String address,
    required double latitude,
    required double longitude,
  }) = _WorkOrderModel;

  factory WorkOrderModel.fromJson(Map<String, Object?> json) => _$WorkOrderModelFromJson(json);

  const WorkOrderModel._();

  WorkOrderEntity toEntity() => WorkOrderEntity(
    id: id,
    title: title,
    description: description,
    priority: priority,
    status: status,
    dueDate: dueDate,
    createdAt: createdAt,
    technicianId: technicianId,
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
    address: entity.address,
    latitude: entity.latitude,
    longitude: entity.longitude,
  );
}