
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_order_group_entity.freezed.dart';


@freezed
class WorkOrderGroupEntity with _$WorkOrderGroupEntity {
  const factory WorkOrderGroupEntity({
    required int id,
    required String title,
    required String description,
    required String createdAt,
    required int createdBy,
  }) = _WorkOrderGroupEntity;
}