part of 'work_order_group_bloc.dart';

@freezed
class WorkOrderGroupState with _$WorkOrderGroupState {
  const factory WorkOrderGroupState.initial() = _Initial;
  const factory WorkOrderGroupState.loading() = _Loading;
  const factory WorkOrderGroupState.loaded(List<WorkOrderGroupEntity> groups) = _Loaded;
  const factory WorkOrderGroupState.error(Failure failure) = _Error;
}
