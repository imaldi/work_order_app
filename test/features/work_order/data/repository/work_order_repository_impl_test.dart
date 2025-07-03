import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart';
import 'package:work_order_app/features/work_order/data/model/work_order_model.dart';
import 'package:work_order_app/features/work_order/data/repository/work_order_repository_impl.dart';
import 'work_order_repository_impl_test.mocks.dart';

@GenerateMocks([WorkOrderLocalDataSource])
void main() {
  late WorkOrderRepositoryImpl repository;
  late MockWorkOrderLocalDataSource mockDataSource;

  setUp(() {
    // Menyediakan dummy value untuk Either<String, List<WorkOrderModel>>
    provideDummy<Either<Failure, List<WorkOrderModel>>>(left(DatabaseFailure('Dummy error')));

    mockDataSource = MockWorkOrderLocalDataSource();
    repository = WorkOrderRepositoryImpl(mockDataSource);
  });

  final tWorkOrderModel = WorkOrderModel(
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
      longitude: 0.0, customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '', groupId: 0
  );
  final tWorkOrdersModel = [tWorkOrderModel];
  final tFailure = DatabaseFailure('Operation failed');

  group('WorkOrderRepositoryImpl', () {
    group('getAllWorkOrders', () {
      test('should return work orders when data source succeeds', () async {
        // Arrange
        when(mockDataSource.getAllWorkOrders())
            .thenAnswer((_) async => Right(tWorkOrdersModel));
        // Act
        final result = await repository.getAllWorkOrders();
        // Assert
        result.fold(
              (failure) {
              fail('Expected Right, but got Left');
          },
              (list) {
                expect(result, Right(list));
              },
        );
        verify(mockDataSource.getAllWorkOrders()).called(1);
      });

      test('should return DatabaseFailure when data source fails', () async {
        // Arrange
        when(mockDataSource.getAllWorkOrders())
            .thenAnswer((_) async => Left(tFailure));
        // Act
        final result = await repository.getAllWorkOrders();
        // Assert
        expect(result, Left(tFailure));
        verify(mockDataSource.getAllWorkOrders()).called(1);
      });
    });

    group('searchWorkOrders', () {
      final params = SearchWorkOrdersParams(query: 'Test');
      test('should return work orders when data source succeeds', () async {
        // Arrange
        when(mockDataSource.searchWorkOrders(params.query))
            .thenAnswer((_) async => Right(tWorkOrdersModel));
        // Act
        final result = await repository.searchWorkOrders(params.query);
        // Assert
        // expect(result, Right(tWorkOrdersEntity));
        result.fold(
              (failure) {
            fail('Expected Right, but got Left');
          },
              (list) {
            expect(result, Right(list));
          },
        );
        verify(mockDataSource.searchWorkOrders(params.query)).called(1);
      });

      test('should return DatabaseFailure when data source fails', () async {
        // Arrange
        when(mockDataSource.searchWorkOrders(params.query))
            .thenAnswer((_) async => Left(tFailure));
        // Act
        final result = await repository.searchWorkOrders(params.query);
        // Assert
        expect(result, Left(tFailure));
        verify(mockDataSource.searchWorkOrders(params.query)).called(1);
      });
    });
    // test('should get all work orders and map models to entities', () async {
    //   final workOrderModel = WorkOrderModel(
    //     id: 1,
    //     title: 'Fix AC',
    //     description: 'Repair air conditioner',
    //     priority: 'High',
    //     status: 'Pending',
    //     dueDate: '2025-07-01',
    //     technicianId: '1',
    //     address: 'Jl. Contoh No. 123',
    //     latitude: -6.2,
    //     longitude: 106.8,
    //   );
    //
    //   when(mockDataSource.getAllWorkOrders()).thenAnswer((_) async => right([workOrderModel]));
    //
    //   final result = await repository.getAllWorkOrders();
    //
    //   expect(result.isRight(), isTrue);
    //   result.fold(
    //         (error) => fail('Expected right, got left: $error'),
    //         (entities) {
    //       expect(entities, hasLength(1));
    //       expect(entities.first.id, workOrderModel.id);
    //       expect(entities.first.title, workOrderModel.title);
    //     },
    //   );
    //   verify(mockDataSource.getAllWorkOrders()).called(1);
    // });
    //
    // test('should return error when data source fails', () async {
    //   when(mockDataSource.getAllWorkOrders()).thenAnswer((_) async => left(DatabaseFailure('Database error')));
    //
    //   final result = await repository.getAllWorkOrders();
    //
    //   expect(result, left(DatabaseFailure('Database error')));
    //   verify(mockDataSource.getAllWorkOrders()).called(1);
    // });
  });
}