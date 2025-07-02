import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/features/work_order_group/domain/entity/work_order_group_entity.dart';
import 'package:work_order_app/features/work_order_group/domain/usecases/create_work_order_group.dart';
import 'package:work_order_app/features/work_order_group/domain/usecases/delete_work_order_group.dart';
import 'package:work_order_app/features/work_order_group/domain/usecases/update_work_order_group.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usecases/get_all_work_order_groups.dart';

part 'work_order_group_event.dart';
part 'work_order_group_state.dart';
part 'work_order_group_bloc.freezed.dart';

@lazySingleton
class WorkOrderGroupBloc extends Bloc<WorkOrderGroupEvent, WorkOrderGroupState> {
  final CreateWorkOrderGroup createWorkOrderGroup;
  final GetAllWorkOrderGroups getAllWorkOrderGroups;
  final UpdateWorkOrderGroup updateWorkOrderGroup;
  final DeleteWorkOrderGroup deleteWorkOrderGroup;

  WorkOrderGroupBloc(
      this.getAllWorkOrderGroups,
      this.createWorkOrderGroup,
      this.updateWorkOrderGroup,
      this.deleteWorkOrderGroup,
      ) : super(const WorkOrderGroupState.initial()) {
    on<GetAllWorkOrderGroupsEvent>(_onGetAllWorkOrderGroups);
    on<CreateWorkOrderGroupEvent>(_onAddWorkOrderGroup);
    on<UpdateWorkOrderGroupEvent>(_onUpdateWorkOrderGroup);
    on<DeleteWorkOrderGroupEvent>(_onDeleteWorkOrderGroup);
  }

  FutureOr<void> _onGetAllWorkOrderGroups(GetAllWorkOrderGroupsEvent event, Emitter<WorkOrderGroupState> emit) async {
    emit(const WorkOrderGroupState.loading());
    final result = await getAllWorkOrderGroups(
      NoParams(),
    ); // Kalau mau begini, di test nya harus sediakan stub nya
    result.fold(
          (error) => emit(WorkOrderGroupState.error(error)),
          (workOrders) => emit(WorkOrderGroupState.loaded(workOrders)),
    );
  }

  FutureOr<void> _onAddWorkOrderGroup(CreateWorkOrderGroupEvent event, Emitter<WorkOrderGroupState> emit) async {
    emit(const WorkOrderGroupState.loading());
    final result = await createWorkOrderGroup(event.params);
    result.fold(
          (error) => emit(WorkOrderGroupState.error(error)),
          (_) => add(const GetAllWorkOrderGroupsEvent()),
    );
  }

  FutureOr<void> _onUpdateWorkOrderGroup(UpdateWorkOrderGroupEvent event, Emitter<WorkOrderGroupState> emit) async {
    emit(const WorkOrderGroupState.loading());
    final result = await updateWorkOrderGroup(event.params);
    result.fold(
          (error) => emit(WorkOrderGroupState.error(error)),
          (_) => add(const GetAllWorkOrderGroupsEvent()),
    );
  }

  FutureOr<void> _onDeleteWorkOrderGroup(DeleteWorkOrderGroupEvent event, Emitter<WorkOrderGroupState> emit) async {
    emit(const WorkOrderGroupState.loading());
    final result = await deleteWorkOrderGroup(event.params);
    result.fold(
          (error) => emit(WorkOrderGroupState.error(error)),
          (_) => add(const GetAllWorkOrderGroupsEvent()),
    );
  }
}
