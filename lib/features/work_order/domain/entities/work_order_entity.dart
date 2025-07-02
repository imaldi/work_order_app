import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_order_entity.freezed.dart';

@freezed
abstract class WorkOrderEntity with _$WorkOrderEntity {
  const factory WorkOrderEntity({
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
  }) = _WorkOrderEntity;
}