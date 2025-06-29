part of 'work_order_bloc.dart';


@freezed
abstract class WorkOrderEvent with _$WorkOrderEvent {
  const factory WorkOrderEvent.loadWorkOrders() = LoadWorkOrdersEvent;
  const factory WorkOrderEvent.addWorkOrder(WorkOrderEntity workOrder) = AddWorkOrderEvent;
  const factory WorkOrderEvent.updateWorkOrder(WorkOrderEntity workOrder) = UpdateWorkOrderEvent;
  const factory WorkOrderEvent.deleteWorkOrder(int id) = DeleteWorkOrderEvent;
  const factory WorkOrderEvent.searchWorkOrdersEvent(String query) = SearchWorkOrdersEvent;
  const factory WorkOrderEvent.filterWorkOrdersEvent(FilterWorkOrderParams params) = FilterWorkOrdersEvent;
  const factory WorkOrderEvent.sortWorkOrdersEvent(SortWorkOrdersParams params) = SortWorkOrdersEvent;
}