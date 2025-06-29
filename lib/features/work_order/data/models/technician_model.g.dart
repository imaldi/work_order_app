// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technician_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TechnicianModel _$TechnicianModelFromJson(Map<String, dynamic> json) =>
    _TechnicianModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      contact: json['contact'] as String?,
    );

Map<String, dynamic> _$TechnicianModelToJson(_TechnicianModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contact': instance.contact,
    };
