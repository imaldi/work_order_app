part of 'work_order_bloc.dart';


@freezed
abstract class WorkOrderEvent with _$WorkOrderEvent {
  const factory WorkOrderEvent.loadWorkOrders() = LoadWorkOrdersEvent;
  const factory WorkOrderEvent.addWorkOrder(AddWorkOrdersParams params) = AddWorkOrderEvent;
  const factory WorkOrderEvent.updateWorkOrder(UpdateWorkOrdersParams params) = UpdateWorkOrderEvent;
  const factory WorkOrderEvent.deleteWorkOrder(QueryIdParams params) = DeleteWorkOrderEvent;
  const factory WorkOrderEvent.searchWorkOrdersEvent(SearchWorkOrdersParams params) = SearchWorkOrdersEvent;
  const factory WorkOrderEvent.filterWorkOrdersEvent(FilterWorkOrderParams params) = FilterWorkOrdersEvent;
  const factory WorkOrderEvent.sortWorkOrdersEvent(SortWorkOrdersParams params) = SortWorkOrdersEvent;
}