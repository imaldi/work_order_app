// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkOrderEntity {

 int get id; String get title; String get description; String get priority; String get status; String get dueDate; String get technicianId; String get address; double get latitude; double get longitude;
/// Create a copy of WorkOrderEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrderEntityCopyWith<WorkOrderEntity> get copyWith => _$WorkOrderEntityCopyWithImpl<WorkOrderEntity>(this as WorkOrderEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.technicianId, technicianId) || other.technicianId == technicianId)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,priority,status,dueDate,technicianId,address,latitude,longitude);

@override
String toString() {
  return 'WorkOrderEntity(id: $id, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, technicianId: $technicianId, address: $address, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $WorkOrderEntityCopyWith<$Res>  {
  factory $WorkOrderEntityCopyWith(WorkOrderEntity value, $Res Function(WorkOrderEntity) _then) = _$WorkOrderEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String priority, String status, String dueDate, String technicianId, String address, double latitude, double longitude
});




}
/// @nodoc
class _$WorkOrderEntityCopyWithImpl<$Res>
    implements $WorkOrderEntityCopyWith<$Res> {
  _$WorkOrderEntityCopyWithImpl(this._self, this._then);

  final WorkOrderEntity _self;
  final $Res Function(WorkOrderEntity) _then;

/// Create a copy of WorkOrderEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? technicianId = null,Object? address = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String,technicianId: null == technicianId ? _self.technicianId : technicianId // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _WorkOrderEntity implements WorkOrderEntity {
  const _WorkOrderEntity({required this.id, required this.title, required this.description, required this.priority, required this.status, required this.dueDate, required this.technicianId, required this.address, required this.latitude, required this.longitude});
  

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String priority;
@override final  String status;
@override final  String dueDate;
@override final  String technicianId;
@override final  String address;
@override final  double latitude;
@override final  double longitude;

/// Create a copy of WorkOrderEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkOrderEntityCopyWith<_WorkOrderEntity> get copyWith => __$WorkOrderEntityCopyWithImpl<_WorkOrderEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkOrderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.technicianId, technicianId) || other.technicianId == technicianId)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,priority,status,dueDate,technicianId,address,latitude,longitude);

@override
String toString() {
  return 'WorkOrderEntity(id: $id, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, technicianId: $technicianId, address: $address, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$WorkOrderEntityCopyWith<$Res> implements $WorkOrderEntityCopyWith<$Res> {
  factory _$WorkOrderEntityCopyWith(_WorkOrderEntity value, $Res Function(_WorkOrderEntity) _then) = __$WorkOrderEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String priority, String status, String dueDate, String technicianId, String address, double latitude, double longitude
});




}
/// @nodoc
class __$WorkOrderEntityCopyWithImpl<$Res>
    implements _$WorkOrderEntityCopyWith<$Res> {
  __$WorkOrderEntityCopyWithImpl(this._self, this._then);

  final _WorkOrderEntity _self;
  final $Res Function(_WorkOrderEntity) _then;

/// Create a copy of WorkOrderEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? technicianId = null,Object? address = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_WorkOrderEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String,technicianId: null == technicianId ? _self.technicianId : technicianId // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
