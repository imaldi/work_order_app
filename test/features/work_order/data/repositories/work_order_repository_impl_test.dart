import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart';
import 'package:work_order_app/features/work_order/data/models/work_order_model.dart';
import 'package:work_order_app/features/work_order/data/repositories/work_order_repository_impl.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'work_order_repository_impl_test.mocks.dart';

@GenerateMocks([WorkOrderLocalDataSource])
void main() {
  late WorkOrderRepositoryImpl repository;
  late MockWorkOrderLocalDataSource mockDataSource;

  setUp(() {
    // Menyediakan dummy value untuk Either<String, List<WorkOrderModel>>
    provideDummy<Either<String, List<WorkOrderModel>>>(left('Dummy error'));

    mockDataSource = MockWorkOrderLocalDataSource();
    repository = WorkOrderRepositoryImpl(mockDataSource);
  });

  group('WorkOrderRepositoryImpl', () {
    test('should get all work orders and map models to entities', () async {
      final workOrderModel = WorkOrderModel(
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
      );

      when(mockDataSource.getAllWorkOrders()).thenAnswer((_) async => right([workOrderModel]));

      final result = await repository.getAllWorkOrders();

      expect(result.isRight(), isTrue);
      result.fold(
            (error) => fail('Expected right, got left: $error'),
            (entities) {
          expect(entities, hasLength(1));
          expect(entities.first.id, workOrderModel.id);
          expect(entities.first.title, workOrderModel.title);
        },
      );
      verify(mockDataSource.getAllWorkOrders()).called(1);
    });

    test('should return error when data source fails', () async {
      when(mockDataSource.getAllWorkOrders()).thenAnswer((_) async => left('Database error'));

      final result = await repository.getAllWorkOrders();

      expect(result, left('Database error'));
      verify(mockDataSource.getAllWorkOrders()).called(1);
    });
  });
}