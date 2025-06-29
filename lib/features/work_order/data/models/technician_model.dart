import 'package:freezed_annotation/freezed_annotation.dart';

part 'technician_model.freezed.dart';
part 'technician_model.g.dart';

@freezed
abstract class TechnicianModel with _$TechnicianModel {
  const factory TechnicianModel({
    required int id,
    required String name,
    String? contact,
  }) = _TechnicianModel;

  factory TechnicianModel.fromJson(Map<String, Object?> json) => _$TechnicianModelFromJson(json);
}