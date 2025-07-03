import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/add_work_order.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/delete_work_order.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/filter_work_orders.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/get_all_work_orders.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/search_work_orders.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/sort_work_orders.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/update_work_order.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';
import 'work_order_bloc_test.mocks.dart';

@GenerateMocks([
  AddWorkOrder,
  GetAllWorkOrders,
  UpdateWorkOrder,
  DeleteWorkOrder,
  SearchWorkOrders,
  SortWorkOrders,
  FilterWorkOrders,
])
void main() {
  late WorkOrderBloc bloc;
  late MockAddWorkOrder mockAddWorkOrder;
  late MockGetAllWorkOrders mockLoadWorkOrders;
  late MockUpdateWorkOrder mockUpdateWorkOrder;
  late MockDeleteWorkOrder mockDeleteWorkOrder;
  late MockSearchWorkOrders mockSearchWorkOrders;
  late MockSortWorkOrders mockSortWorkOrders;
  late MockFilterWorkOrders mockFilterWorkOrders;

  setUp(() {
    // Menyediakan dummy value untuk Either<String, List<WorkOrderModel>>
    provideDummy<Either<Failure, List<WorkOrderEntity>>>(left(DatabaseFailure('Dummy error')));
    provideDummy<Either<Failure, Unit>>(left(DatabaseFailure('Dummy error')));

    mockAddWorkOrder = MockAddWorkOrder();
    mockLoadWorkOrders = MockGetAllWorkOrders();
    mockUpdateWorkOrder = MockUpdateWorkOrder();
    mockDeleteWorkOrder = MockDeleteWorkOrder();
    mockSearchWorkOrders = MockSearchWorkOrders();
    mockSortWorkOrders = MockSortWorkOrders();
    mockFilterWorkOrders = MockFilterWorkOrders();
    bloc = WorkOrderBloc(
      mockAddWorkOrder,
      mockLoadWorkOrders,
      mockUpdateWorkOrder,
      mockDeleteWorkOrder,
      mockSearchWorkOrders,
      mockSortWorkOrders,
      mockFilterWorkOrders,
    );
  });

  final tWorkOrder = WorkOrderEntity(
    id: 1,
    title: 'Test',
    description: "Oke",
    priority: '',
    status: '',
    dueDate: '',
    createdAt: '',
    technicianId: 0,
    address: '',
    latitude: 0.0,
    longitude: 0.0, customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '',
  );
  final tWorkOrders = [tWorkOrder];
  final tFailure = DatabaseFailure('Operation failed');

  group('WorkOrderBloc', () {
    test('initial state should be WorkOrderInitial', () {
      expect(bloc.state, WorkOrderInitial());
    });

    group('LoadWorkOrdersEvent', () {
      test('should emit [WorkOrderLoaded] when load succeeds', () async {
        // Arrange
        // ini sediakan stub nya
        when(mockLoadWorkOrders(any)).thenAnswer((_) async => Right(tWorkOrders));
        // Act
        bloc.add(const LoadWorkOrdersEvent());
        await untilCalled(mockLoadWorkOrders(any));
        // Assert
        expectLater(bloc.stream, emitsInOrder([WorkOrderLoaded(tWorkOrders)]));
        verify(mockLoadWorkOrders(any)).called(1);
      });

      test('should emit [WorkOrderError] when load fails', () async {
        // Arrange
        when(mockLoadWorkOrders(any)).thenAnswer((_) async => Left(tFailure));
        // Act
        bloc.add(const LoadWorkOrdersEvent());
        await untilCalled(mockLoadWorkOrders(any));
        // Assert
        expectLater(bloc.stream, emitsInOrder([WorkOrderError(tFailure)]));
        verify(mockLoadWorkOrders(any)).called(1);
      });
    });
  });

  group('AddWorkOrderEvent', () {
    final params = AddWorkOrdersParams(workOrderEntity: tWorkOrder);

    blocTest<WorkOrderBloc, WorkOrderState>(
      'emits [loading, loaded] when add succeeds',
      setUp: () {
        when(mockAddWorkOrder(params)).thenAnswer((_) async => Right(unit));
        when(mockLoadWorkOrders(any)).thenAnswer((_) async => Right(tWorkOrders));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(AddWorkOrderEvent(params)),
      expect: () => [const WorkOrderState.loading(), WorkOrderState.loaded(tWorkOrders)],
      verify: (_) {
        verify(mockAddWorkOrder(params)).called(1);
        verify(mockLoadWorkOrders(any)).called(1);
      },
    );

    blocTest<WorkOrderBloc, WorkOrderState>(
      'emits [loading, error] when add fails',
      setUp: () {
        when(mockAddWorkOrder(params)).thenAnswer((_) async => Left(tFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(AddWorkOrderEvent(params)),
      expect: () => [const WorkOrderState.loading(), WorkOrderState.error(tFailure)],
      verify: (_) {
        verify(mockAddWorkOrder(params)).called(1);
        verifyNever(mockLoadWorkOrders(any));
      },
    );
  });

  group('UpdateWorkOrderEvent', () {
    final updatedWorkOrder = tWorkOrder.copyWith(title: "Test Edit");

    final updateTparams = UpdateWorkOrdersParams(workOrderEntity: updatedWorkOrder);

    final updatedWorkOrders = [updatedWorkOrder];
    blocTest<WorkOrderBloc, WorkOrderState>(
      'emits [loading, loaded] when update succeeds',
      setUp: () {
        when(mockUpdateWorkOrder(updateTparams)).thenAnswer((_) async => Right(unit));
        when(mockLoadWorkOrders(any)).thenAnswer((_) async => Right(updatedWorkOrders));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(UpdateWorkOrderEvent(updateTparams));
      },
      expect: () => [const WorkOrderState.loading(), WorkOrderState.loaded(updatedWorkOrders)],
      verify: (_) {
        verify(mockUpdateWorkOrder(updateTparams)).called(1);
        verify(mockLoadWorkOrders(any)).called(1);
      },
    );
    blocTest<WorkOrderBloc, WorkOrderState>(
      'emits [loading, error] when update fails',
      setUp: () {
        when(mockUpdateWorkOrder(updateTparams)).thenAnswer((_) async => Left(tFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(UpdateWorkOrderEvent(updateTparams)),
      expect: () => [const WorkOrderState.loading(), WorkOrderState.error(tFailure)],
      verify: (_) {
        verify(mockUpdateWorkOrder(updateTparams)).called(1);
        verifyNever(mockLoadWorkOrders(any));
      },
    );
  });

  group('DeleteWorkOrderEvent', () {
    final params = QueryIdParams(id: tWorkOrder.id);

    blocTest<WorkOrderBloc, WorkOrderState>(
      'emits [loading, loaded] when delete succeeds',
      setUp: () {
        when(mockDeleteWorkOrder(params)).thenAnswer((_) async => Right(unit));
        when(mockLoadWorkOrders(any)).thenAnswer((_) async => Right([]));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(DeleteWorkOrderEvent(params)),
      expect: () => [const WorkOrderState.loading(), WorkOrderState.loaded([])],
      verify: (_) {
        verify(mockDeleteWorkOrder(params)).called(1);
        verify(mockLoadWorkOrders(any)).called(1);
      },
    );

    blocTest<WorkOrderBloc, WorkOrderState>(
      'emits [loading, error] when delete fails',
      setUp: () {
        when(mockDeleteWorkOrder(params)).thenAnswer((_) async => Left(tFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(DeleteWorkOrderEvent(params)),
      expect: () => [const WorkOrderState.loading(), WorkOrderState.error(tFailure)],
      verify: (_) {
        verify(mockDeleteWorkOrder(params)).called(1);
        verifyNever(mockLoadWorkOrders(any));
      },
    );
  });

  // Tambah test serupa untuk UpdateWorkOrderEvent, DeleteWorkOrderEvent, dll.
  group('SearchWorkOrdersEvent', () {
    final params = SearchWorkOrdersParams(query: 'test');
    test('should emit [WorkOrderLoaded] when search succeeds', () async {
      // Arrange
      when(mockSearchWorkOrders(params)).thenAnswer((_) async => Right(tWorkOrders));
      // Act
      bloc.add(SearchWorkOrdersEvent(params));
      await untilCalled(mockSearchWorkOrders(params));
      // Assert
      expectLater(bloc.stream, emitsInOrder([WorkOrderLoaded(tWorkOrders)]));
      verify(mockSearchWorkOrders(params)).called(1);
    });

    test('should emit [WorkOrderError] when search fails', () async {
      // Arrange
      when(mockSearchWorkOrders(params)).thenAnswer((_) async => Left(tFailure));
      // Act
      bloc.add(SearchWorkOrdersEvent(params));
      await untilCalled(mockSearchWorkOrders(params));
      // Assert
      expectLater(bloc.stream, emitsInOrder([WorkOrderError(tFailure)]));
      verify(mockSearchWorkOrders(params)).called(1);
    });
  });

  /// ini tes awal
  blocTest<WorkOrderBloc, WorkOrderState>(
    'emits [loading, loaded] when LoadWorkOrdersEvent is added and getAllWorkOrders succeeds',
    setUp: () {
      provideDummy<Either<String, List<WorkOrderEntity>>>(left('Dummy error'));
      when(mockLoadWorkOrders(any)).thenAnswer(
        (_) async => right([
          WorkOrderEntity(
            id: 1,
            title: 'Fix AC',
            description: 'Repair air conditioner',
            priority: 'High',
            status: 'Pending',
            dueDate: '2025-07-01 00:00',
            createdAt: '2025-06-01 00:00',
            technicianId: 1,
            address: 'Jl. Contoh No. 123',
            latitude: -6.2,
            longitude: 106.8, customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '',
          ),
        ]),
      );
    },
    build: () => bloc,
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
          dueDate: '2025-07-01 00:00',
          createdAt: '2025-06-01 00:00',
          technicianId: 1,
          address: 'Jl. Contoh No. 123',
          latitude: -6.2,
          longitude: 106.8, customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '',
        ),
      ]),
    ],
  );
}
