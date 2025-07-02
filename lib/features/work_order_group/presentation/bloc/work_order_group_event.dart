part of 'work_order_group_bloc.dart';

@freezed
class WorkOrderGroupEvent with _$WorkOrderGroupEvent {
  const factory WorkOrderGroupEvent.getAllWorkOrderGroups() = GetAllWorkOrderGroupsEvent;
  const factory WorkOrderGroupEvent.addWorkOrderGroup(CreateEntityParams<WorkOrderGroupEntity> params) = CreateWorkOrderGroupEvent;
  const factory WorkOrderGroupEvent.updateWorkOrderGroup(CreateEntityParams<WorkOrderGroupEntity> params) = UpdateWorkOrderGroupEvent;
  const factory WorkOrderGroupEvent.deleteWorkOrderGroup(QueryIdParams params) = DeleteWorkOrderGroupEvent;

}
