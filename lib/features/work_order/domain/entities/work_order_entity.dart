import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_order_entity.freezed.dart';

@freezed
abstract class WorkOrderEntity with _$WorkOrderEntity {
  const factory WorkOrderEntity({
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
  }) = _WorkOrderEntity;
}