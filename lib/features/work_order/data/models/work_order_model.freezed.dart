// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkOrderModel {

 int get id; String get title; String get description; String get priority; String get status; String get dueDate; String get technicianId; String get address; double get latitude; double get longitude;
/// Create a copy of WorkOrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrderModelCopyWith<WorkOrderModel> get copyWith => _$WorkOrderModelCopyWithImpl<WorkOrderModel>(this as WorkOrderModel, _$identity);

  /// Serializes this WorkOrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.technicianId, technicianId) || other.technicianId == technicianId)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,priority,status,dueDate,technicianId,address,latitude,longitude);

@override
String toString() {
  return 'WorkOrderModel(id: $id, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, technicianId: $technicianId, address: $address, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $WorkOrderModelCopyWith<$Res>  {
  factory $WorkOrderModelCopyWith(WorkOrderModel value, $Res Function(WorkOrderModel) _then) = _$WorkOrderModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String priority, String status, String dueDate, String technicianId, String address, double latitude, double longitude
});




}
/// @nodoc
class _$WorkOrderModelCopyWithImpl<$Res>
    implements $WorkOrderModelCopyWith<$Res> {
  _$WorkOrderModelCopyWithImpl(this._self, this._then);

  final WorkOrderModel _self;
  final $Res Function(WorkOrderModel) _then;

/// Create a copy of WorkOrderModel
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
@JsonSerializable()

class _WorkOrderModel implements WorkOrderModel {
  const _WorkOrderModel({required this.id, required this.title, required this.description, required this.priority, required this.status, required this.dueDate, required this.technicianId, required this.address, required this.latitude, required this.longitude});
  factory _WorkOrderModel.fromJson(Map<String, dynamic> json) => _$WorkOrderModelFromJson(json);

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

/// Create a copy of WorkOrderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkOrderModelCopyWith<_WorkOrderModel> get copyWith => __$WorkOrderModelCopyWithImpl<_WorkOrderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkOrderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkOrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.technicianId, technicianId) || other.technicianId == technicianId)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,priority,status,dueDate,technicianId,address,latitude,longitude);

@override
String toString() {
  return 'WorkOrderModel(id: $id, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, technicianId: $technicianId, address: $address, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$WorkOrderModelCopyWith<$Res> implements $WorkOrderModelCopyWith<$Res> {
  factory _$WorkOrderModelCopyWith(_WorkOrderModel value, $Res Function(_WorkOrderModel) _then) = __$WorkOrderModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String priority, String status, String dueDate, String technicianId, String address, double latitude, double longitude
});




}
/// @nodoc
class __$WorkOrderModelCopyWithImpl<$Res>
    implements _$WorkOrderModelCopyWith<$Res> {
  __$WorkOrderModelCopyWithImpl(this._self, this._then);

  final _WorkOrderModel _self;
  final $Res Function(_WorkOrderModel) _then;

/// Create a copy of WorkOrderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? technicianId = null,Object? address = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_WorkOrderModel(
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
