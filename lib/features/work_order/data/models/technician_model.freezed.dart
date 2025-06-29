// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'technician_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TechnicianModel {

 int get id; String get name; String? get contact;
/// Create a copy of TechnicianModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TechnicianModelCopyWith<TechnicianModel> get copyWith => _$TechnicianModelCopyWithImpl<TechnicianModel>(this as TechnicianModel, _$identity);

  /// Serializes this TechnicianModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TechnicianModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contact, contact) || other.contact == contact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,contact);

@override
String toString() {
  return 'TechnicianModel(id: $id, name: $name, contact: $contact)';
}


}

/// @nodoc
abstract mixin class $TechnicianModelCopyWith<$Res>  {
  factory $TechnicianModelCopyWith(TechnicianModel value, $Res Function(TechnicianModel) _then) = _$TechnicianModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? contact
});




}
/// @nodoc
class _$TechnicianModelCopyWithImpl<$Res>
    implements $TechnicianModelCopyWith<$Res> {
  _$TechnicianModelCopyWithImpl(this._self, this._then);

  final TechnicianModel _self;
  final $Res Function(TechnicianModel) _then;

/// Create a copy of TechnicianModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? contact = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TechnicianModel implements TechnicianModel {
  const _TechnicianModel({required this.id, required this.name, this.contact});
  factory _TechnicianModel.fromJson(Map<String, dynamic> json) => _$TechnicianModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? contact;

/// Create a copy of TechnicianModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TechnicianModelCopyWith<_TechnicianModel> get copyWith => __$TechnicianModelCopyWithImpl<_TechnicianModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TechnicianModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TechnicianModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contact, contact) || other.contact == contact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,contact);

@override
String toString() {
  return 'TechnicianModel(id: $id, name: $name, contact: $contact)';
}


}

/// @nodoc
abstract mixin class _$TechnicianModelCopyWith<$Res> implements $TechnicianModelCopyWith<$Res> {
  factory _$TechnicianModelCopyWith(_TechnicianModel value, $Res Function(_TechnicianModel) _then) = __$TechnicianModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? contact
});




}
/// @nodoc
class __$TechnicianModelCopyWithImpl<$Res>
    implements _$TechnicianModelCopyWith<$Res> {
  __$TechnicianModelCopyWithImpl(this._self, this._then);

  final _TechnicianModel _self;
  final $Res Function(_TechnicianModel) _then;

/// Create a copy of TechnicianModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? contact = freezed,}) {
  return _then(_TechnicianModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
