// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'technician_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TechnicianEntity {

 int get id; String get name; String? get contact;
/// Create a copy of TechnicianEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TechnicianEntityCopyWith<TechnicianEntity> get copyWith => _$TechnicianEntityCopyWithImpl<TechnicianEntity>(this as TechnicianEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TechnicianEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contact, contact) || other.contact == contact));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,contact);

@override
String toString() {
  return 'TechnicianEntity(id: $id, name: $name, contact: $contact)';
}


}

/// @nodoc
abstract mixin class $TechnicianEntityCopyWith<$Res>  {
  factory $TechnicianEntityCopyWith(TechnicianEntity value, $Res Function(TechnicianEntity) _then) = _$TechnicianEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? contact
});




}
/// @nodoc
class _$TechnicianEntityCopyWithImpl<$Res>
    implements $TechnicianEntityCopyWith<$Res> {
  _$TechnicianEntityCopyWithImpl(this._self, this._then);

  final TechnicianEntity _self;
  final $Res Function(TechnicianEntity) _then;

/// Create a copy of TechnicianEntity
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


class _TechnicianEntity implements TechnicianEntity {
  const _TechnicianEntity({required this.id, required this.name, this.contact});
  

@override final  int id;
@override final  String name;
@override final  String? contact;

/// Create a copy of TechnicianEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TechnicianEntityCopyWith<_TechnicianEntity> get copyWith => __$TechnicianEntityCopyWithImpl<_TechnicianEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TechnicianEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.contact, contact) || other.contact == contact));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,contact);

@override
String toString() {
  return 'TechnicianEntity(id: $id, name: $name, contact: $contact)';
}


}

/// @nodoc
abstract mixin class _$TechnicianEntityCopyWith<$Res> implements $TechnicianEntityCopyWith<$Res> {
  factory _$TechnicianEntityCopyWith(_TechnicianEntity value, $Res Function(_TechnicianEntity) _then) = __$TechnicianEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? contact
});




}
/// @nodoc
class __$TechnicianEntityCopyWithImpl<$Res>
    implements _$TechnicianEntityCopyWith<$Res> {
  __$TechnicianEntityCopyWithImpl(this._self, this._then);

  final _TechnicianEntity _self;
  final $Res Function(_TechnicianEntity) _then;

/// Create a copy of TechnicianEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? contact = freezed,}) {
  return _then(_TechnicianEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
