import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/add_work_order.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/get_all_work_orders.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';
import 'work_order_bloc_test.mocks.dart';

@GenerateMocks([AddWorkOrder, GetAllWorkOrders])
void main() {
  late WorkOrderBloc bloc;
  late MockAddWorkOrder mockAddWorkOrder;
  late MockGetAllWorkOrders mockGetAllWorkOrders;

  setUp(() {
    mockAddWorkOrder = MockAddWorkOrder();
    mockGetAllWorkOrders = MockGetAllWorkOrders();
    bloc = WorkOrderBloc(mockAddWorkOrder, mockGetAllWorkOrders);
  });

  blocTest<WorkOrderBloc, WorkOrderState>(
    'emits [loading, loaded] when LoadWorkOrdersEvent is added and getAllWorkOrders succeeds',
    build: () {
      when(mockGetAllWorkOrders()).thenAnswer((_) async => right([
        WorkOrderEntity(
          id: 1,
          title: 'Fix AC',
          description: 'Repair air conditioner',
          priority: 'High',
          status: 'Pending',
          dueDate: '2025-07-01',
          technicianId: '1',
          address: 'Jl. Contoh No. 123',
          latitude: -6.2,
          longitude: 106.8,
        ),
      ]));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWorkOrdersEvent()),
    expect: () => [
      const WorkOrderState.loading(),
      WorkOrderState.loaded([
        WorkOrderEntity(
          id: 1,
          title: 'Fix AC',
          description: 'Repair air conditioner',
          priority: 'High',
          status: 'Pending',
          dueDate: '2025-07-01',
          technicianId: '1',
          address: 'Jl. Contoh No. 123',
          latitude: -6.2,
          longitude: 106.8,
        ),
      ]),
    ],
  );
}