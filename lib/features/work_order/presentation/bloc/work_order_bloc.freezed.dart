// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkOrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WorkOrderEvent()';
}


}

/// @nodoc
class $WorkOrderEventCopyWith<$Res>  {
$WorkOrderEventCopyWith(WorkOrderEvent _, $Res Function(WorkOrderEvent) __);
}


/// @nodoc


class LoadWorkOrdersEvent implements WorkOrderEvent {
  const LoadWorkOrdersEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadWorkOrdersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WorkOrderEvent.loadWorkOrders()';
}


}




/// @nodoc


class AddWorkOrderEvent implements WorkOrderEvent {
  const AddWorkOrderEvent(this.workOrder);
  

 final  WorkOrderEntity workOrder;

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddWorkOrderEventCopyWith<AddWorkOrderEvent> get copyWith => _$AddWorkOrderEventCopyWithImpl<AddWorkOrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddWorkOrderEvent&&(identical(other.workOrder, workOrder) || other.workOrder == workOrder));
}


@override
int get hashCode => Object.hash(runtimeType,workOrder);

@override
String toString() {
  return 'WorkOrderEvent.addWorkOrder(workOrder: $workOrder)';
}


}

/// @nodoc
abstract mixin class $AddWorkOrderEventCopyWith<$Res> implements $WorkOrderEventCopyWith<$Res> {
  factory $AddWorkOrderEventCopyWith(AddWorkOrderEvent value, $Res Function(AddWorkOrderEvent) _then) = _$AddWorkOrderEventCopyWithImpl;
@useResult
$Res call({
 WorkOrderEntity workOrder
});


$WorkOrderEntityCopyWith<$Res> get workOrder;

}
/// @nodoc
class _$AddWorkOrderEventCopyWithImpl<$Res>
    implements $AddWorkOrderEventCopyWith<$Res> {
  _$AddWorkOrderEventCopyWithImpl(this._self, this._then);

  final AddWorkOrderEvent _self;
  final $Res Function(AddWorkOrderEvent) _then;

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workOrder = null,}) {
  return _then(AddWorkOrderEvent(
null == workOrder ? _self.workOrder : workOrder // ignore: cast_nullable_to_non_nullable
as WorkOrderEntity,
  ));
}

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkOrderEntityCopyWith<$Res> get workOrder {
  
  return $WorkOrderEntityCopyWith<$Res>(_self.workOrder, (value) {
    return _then(_self.copyWith(workOrder: value));
  });
}
}

/// @nodoc


class UpdateWorkOrderEvent implements WorkOrderEvent {
  const UpdateWorkOrderEvent(this.workOrder);
  

 final  WorkOrderEntity workOrder;

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateWorkOrderEventCopyWith<UpdateWorkOrderEvent> get copyWith => _$UpdateWorkOrderEventCopyWithImpl<UpdateWorkOrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateWorkOrderEvent&&(identical(other.workOrder, workOrder) || other.workOrder == workOrder));
}


@override
int get hashCode => Object.hash(runtimeType,workOrder);

@override
String toString() {
  return 'WorkOrderEvent.updateWorkOrder(workOrder: $workOrder)';
}


}

/// @nodoc
abstract mixin class $UpdateWorkOrderEventCopyWith<$Res> implements $WorkOrderEventCopyWith<$Res> {
  factory $UpdateWorkOrderEventCopyWith(UpdateWorkOrderEvent value, $Res Function(UpdateWorkOrderEvent) _then) = _$UpdateWorkOrderEventCopyWithImpl;
@useResult
$Res call({
 WorkOrderEntity workOrder
});


$WorkOrderEntityCopyWith<$Res> get workOrder;

}
/// @nodoc
class _$UpdateWorkOrderEventCopyWithImpl<$Res>
    implements $UpdateWorkOrderEventCopyWith<$Res> {
  _$UpdateWorkOrderEventCopyWithImpl(this._self, this._then);

  final UpdateWorkOrderEvent _self;
  final $Res Function(UpdateWorkOrderEvent) _then;

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workOrder = null,}) {
  return _then(UpdateWorkOrderEvent(
null == workOrder ? _self.workOrder : workOrder // ignore: cast_nullable_to_non_nullable
as WorkOrderEntity,
  ));
}

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkOrderEntityCopyWith<$Res> get workOrder {
  
  return $WorkOrderEntityCopyWith<$Res>(_self.workOrder, (value) {
    return _then(_self.copyWith(workOrder: value));
  });
}
}

/// @nodoc


class DeleteWorkOrderEvent implements WorkOrderEvent {
  const DeleteWorkOrderEvent(this.id);
  

 final  int id;

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteWorkOrderEventCopyWith<DeleteWorkOrderEvent> get copyWith => _$DeleteWorkOrderEventCopyWithImpl<DeleteWorkOrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteWorkOrderEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'WorkOrderEvent.deleteWorkOrder(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteWorkOrderEventCopyWith<$Res> implements $WorkOrderEventCopyWith<$Res> {
  factory $DeleteWorkOrderEventCopyWith(DeleteWorkOrderEvent value, $Res Function(DeleteWorkOrderEvent) _then) = _$DeleteWorkOrderEventCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$DeleteWorkOrderEventCopyWithImpl<$Res>
    implements $DeleteWorkOrderEventCopyWith<$Res> {
  _$DeleteWorkOrderEventCopyWithImpl(this._self, this._then);

  final DeleteWorkOrderEvent _self;
  final $Res Function(DeleteWorkOrderEvent) _then;

/// Create a copy of WorkOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteWorkOrderEvent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$WorkOrderState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WorkOrderState()';
}


}

/// @nodoc
class $WorkOrderStateCopyWith<$Res>  {
$WorkOrderStateCopyWith(WorkOrderState _, $Res Function(WorkOrderState) __);
}


/// @nodoc


class WorkOrderInitial implements WorkOrderState {
  const WorkOrderInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WorkOrderState.initial()';
}


}




/// @nodoc


class WorkOrderLoading implements WorkOrderState {
  const WorkOrderLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WorkOrderState.loading()';
}


}




/// @nodoc


class WorkOrderLoaded implements WorkOrderState {
  const WorkOrderLoaded(final  List<WorkOrderEntity> workOrders): _workOrders = workOrders;
  

 final  List<WorkOrderEntity> _workOrders;
 List<WorkOrderEntity> get workOrders {
  if (_workOrders is EqualUnmodifiableListView) return _workOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workOrders);
}


/// Create a copy of WorkOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrderLoadedCopyWith<WorkOrderLoaded> get copyWith => _$WorkOrderLoadedCopyWithImpl<WorkOrderLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderLoaded&&const DeepCollectionEquality().equals(other._workOrders, _workOrders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_workOrders));

@override
String toString() {
  return 'WorkOrderState.loaded(workOrders: $workOrders)';
}


}

/// @nodoc
abstract mixin class $WorkOrderLoadedCopyWith<$Res> implements $WorkOrderStateCopyWith<$Res> {
  factory $WorkOrderLoadedCopyWith(WorkOrderLoaded value, $Res Function(WorkOrderLoaded) _then) = _$WorkOrderLoadedCopyWithImpl;
@useResult
$Res call({
 List<WorkOrderEntity> workOrders
});




}
/// @nodoc
class _$WorkOrderLoadedCopyWithImpl<$Res>
    implements $WorkOrderLoadedCopyWith<$Res> {
  _$WorkOrderLoadedCopyWithImpl(this._self, this._then);

  final WorkOrderLoaded _self;
  final $Res Function(WorkOrderLoaded) _then;

/// Create a copy of WorkOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workOrders = null,}) {
  return _then(WorkOrderLoaded(
null == workOrders ? _self._workOrders : workOrders // ignore: cast_nullable_to_non_nullable
as List<WorkOrderEntity>,
  ));
}


}

/// @nodoc


class WorkOrderError implements WorkOrderState {
  const WorkOrderError(this.message);
  

 final  String message;

/// Create a copy of WorkOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrderErrorCopyWith<WorkOrderError> get copyWith => _$WorkOrderErrorCopyWithImpl<WorkOrderError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrderError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WorkOrderState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $WorkOrderErrorCopyWith<$Res> implements $WorkOrderStateCopyWith<$Res> {
  factory $WorkOrderErrorCopyWith(WorkOrderError value, $Res Function(WorkOrderError) _then) = _$WorkOrderErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WorkOrderErrorCopyWithImpl<$Res>
    implements $WorkOrderErrorCopyWith<$Res> {
  _$WorkOrderErrorCopyWithImpl(this._self, this._then);

  final WorkOrderError _self;
  final $Res Function(WorkOrderError) _then;

/// Create a copy of WorkOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WorkOrderError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
