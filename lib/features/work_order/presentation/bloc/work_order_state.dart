part of 'work_order_bloc.dart';

@freezed
abstract class WorkOrderState with _$WorkOrderState {
  const factory WorkOrderState.initial() = WorkOrderInitial;
  const factory WorkOrderState.loading() = WorkOrderLoading;
  const factory WorkOrderState.loaded(List<WorkOrderEntity> workOrders) = WorkOrderLoaded;
  const factory WorkOrderState.error(String message) = WorkOrderError;
}