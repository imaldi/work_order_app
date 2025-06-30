import 'package:freezed_annotation/freezed_annotation.dart';

part 'technician_entity.freezed.dart';

@freezed
abstract class TechnicianEntity with _$TechnicianEntity {
  const factory TechnicianEntity({
    required int id,
    required String name,
    String? contact,
  }) = _TechnicianEntity;
}