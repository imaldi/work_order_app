import 'package:freezed_annotation/freezed_annotation.dart';

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
    required String technicianId,
    required String address,
    required double latitude,
    required double longitude,
  }) = _WorkOrderModel;

  factory WorkOrderModel.fromJson(Map<String, Object?> json) => _$WorkOrderModelFromJson(json);
}