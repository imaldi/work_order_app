import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/delete_work_order.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/filter_work_orders.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/sort_work_orders.dart';

import '../../../../core/params/params.dart';
import '../../domain/entities/work_order_entity.dart';
import '../../domain/use_cases/add_work_order.dart';
import '../../domain/use_cases/get_all_work_orders.dart';
import '../../domain/use_cases/search_work_orders.dart';
import '../../domain/use_cases/update_work_order.dart';

part 'work_order_event.dart';
part 'work_order_state.dart';
part 'work_order_bloc.freezed.dart';

@injectable
class WorkOrderBloc extends Bloc<WorkOrderEvent, WorkOrderState> {
  final AddWorkOrder addWorkOrder;
  final GetAllWorkOrders getAllWorkOrders;
  final UpdateWorkOrder updateWorkOrder;
  final DeleteWorkOrder deleteWorkOrder;
  final SearchWorkOrders searchWorkOrders;
  final SortWorkOrders sortWorkOrders;
  final FilterWorkOrders filterWorkOrders;

  WorkOrderBloc(
      this.addWorkOrder,
      this.getAllWorkOrders,
      this.updateWorkOrder,
      this.deleteWorkOrder,
      this.searchWorkOrders,
      this.sortWorkOrders,
      this.filterWorkOrders,
      ) : super(const WorkOrderState.initial()) {
    on<LoadWorkOrdersEvent>(_onLoadWorkOrders);
    on<AddWorkOrderEvent>(_onAddWorkOrder);
    on<UpdateWorkOrderEvent>(_onUpdateWorkOrder);
    on<DeleteWorkOrderEvent>(_onDeleteWorkOrder);
    on<SearchWorkOrdersEvent>(_onSearchWorkOrders);
    on<SortWorkOrdersEvent>(_onSortWorkOrders);
    on<FilterWorkOrdersEvent>(_onFilterWorkOrders);
  }

  Future<void> _onLoadWorkOrders(LoadWorkOrdersEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await getAllWorkOrders();
    result.fold(
          (error) => emit(WorkOrderState.error(error)),
          (workOrders) => emit(WorkOrderState.loaded(workOrders)),
    );
  }

  Future<void> _onAddWorkOrder(AddWorkOrderEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await addWorkOrder(event.workOrder);
    result.fold(
          (error) => emit(WorkOrderState.error(error)),
          (_) async {
        final workOrders = await getAllWorkOrders();
        workOrders.fold(
              (error) => emit(WorkOrderState.error(error)),
              (workOrders) => emit(WorkOrderState.loaded(workOrders)),
        );
      },
    );
  }

  Future<void> _onUpdateWorkOrder(UpdateWorkOrderEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await updateWorkOrder(event.workOrder);
    result.fold(
        (error) => emit(WorkOrderState.error(error)),
        (_) async {
          final workOrders = await getAllWorkOrders();
          workOrders.fold(
              (error) => emit(WorkOrderState.error(error)),
              (workOrders) => emit(WorkOrderState.loaded(workOrders))
          );
        }
    );
  }

  Future<void> _onDeleteWorkOrder(DeleteWorkOrderEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await deleteWorkOrder(event.id);
    result.fold(
            (error) => emit(WorkOrderState.error(error)),
            (_) async {
          final workOrders = await getAllWorkOrders();
          workOrders.fold(
                  (error) => emit(WorkOrderState.error(error)),
                  (workOrders) => emit(WorkOrderState.loaded(workOrders))
          );
        }
    );
  }

  Future<void> _onSearchWorkOrders(SearchWorkOrdersEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await searchWorkOrders(event.query);
    result.fold(
          (error) => emit(WorkOrderState.error(error)),
          (workOrders) => emit(WorkOrderState.loaded(workOrders)),
    );
  }

  Future<void> _onSortWorkOrders(SortWorkOrdersEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await sortWorkOrders(event.sortBy,event.ascending);
    result.fold(
          (error) => emit(WorkOrderState.error(error)),
          (workOrders) => emit(WorkOrderState.loaded(workOrders)),
    );
  }

  Future<void> _onFilterWorkOrders(FilterWorkOrdersEvent event, Emitter<WorkOrderState> emit) async {
    emit(const WorkOrderState.loading());
    final result = await filterWorkOrders(event.params);
    result.fold(
          (error) => emit(WorkOrderState.error(error)),
          (workOrders) => emit(WorkOrderState.loaded(workOrders)),
    );
  }
}
