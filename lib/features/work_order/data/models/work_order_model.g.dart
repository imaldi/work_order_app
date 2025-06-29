// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkOrderModel _$WorkOrderModelFromJson(Map<String, dynamic> json) =>
    _WorkOrderModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      dueDate: json['dueDate'] as String,
      technicianId: json['technicianId'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkOrderModelToJson(_WorkOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'status': instance.status,
      'dueDate': instance.dueDate,
      'technicianId': instance.technicianId,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
