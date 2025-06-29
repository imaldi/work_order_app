import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/delete_work_order.dart';

import '../../domain/entities/work_order_entity.dart';
import '../../domain/use_cases/add_work_order.dart';
import '../../domain/use_cases/get_all_work_orders.dart';
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

  WorkOrderBloc(this.addWorkOrder, this.getAllWorkOrders, this.updateWorkOrder, this.deleteWorkOrder) : super(const WorkOrderState.initial()) {
    on<LoadWorkOrdersEvent>(_onLoadWorkOrders);
    on<AddWorkOrderEvent>(_onAddWorkOrder);
    on<UpdateWorkOrderEvent>(_onUpdateWorkOrder);
    on<DeleteWorkOrderEvent>(_onDeleteWorkOrder);
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
    );  }
}
