import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/technician_entity.dart';

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

  const TechnicianModel._();

  TechnicianEntity toEntity() => TechnicianEntity(
    id: id,
    name: name,
    contact: contact,
  );

  static TechnicianModel fromEntity(TechnicianEntity entity) => TechnicianModel(
    id: entity.id,
    name: entity.name,
    contact: entity.contact,
  );
}