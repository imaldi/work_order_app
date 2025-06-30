import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/features/technician/data/data_sources/technician_local_data_source.dart';
import 'package:work_order_app/features/technician/data/model/technician_model.dart';
import 'package:work_order_app/features/technician/data/repository/technician_repository_impl.dart';
import 'technician_repository_impl_test.mocks.dart';

@GenerateMocks([TechnicianLocalDataSource])
void main() {
  late TechnicianRepositoryImpl repository;
  late MockTechnicianLocalDataSource mockDataSource;

  setUp(() {
    // Menyediakan dummy value untuk Either<String, List<TechnicianModel>>
    provideDummy<Either<Failure, List<TechnicianModel>>>(left(DatabaseFailure('Dummy error')));

    mockDataSource = MockTechnicianLocalDataSource();
    repository = TechnicianRepositoryImpl(mockDataSource);
  });

  final tTechnicianModel = TechnicianModel(
    id: 1,
    name: 'Aldi',
    contact: '082233445566',
  );
  final tTechniciansModel = [tTechnicianModel];
  final tFailure = DatabaseFailure('Operation failed');

  group('TechnicianRepositoryImpl', () {
    group('getAllTechnicians', () {
      test('should return technicians when data source succeeds', () async {
        // Arrange
        when(mockDataSource.getAllTechnicians())
            .thenAnswer((_) async => Right(tTechniciansModel));
        // Act
        final result = await repository.getAllTechnicians();
        // Assert
        result.fold(
              (failure) {
              fail('Expected Right, but got Left');
          },
              (list) {
                expect(result, Right(list));
              },
        );
        verify(mockDataSource.getAllTechnicians()).called(1);
      });

      test('should return DatabaseFailure when data source fails', () async {
        // Arrange
        when(mockDataSource.getAllTechnicians())
            .thenAnswer((_) async => Left(tFailure));
        // Act
        final result = await repository.getAllTechnicians();
        // Assert
        expect(result, Left(tFailure));
        verify(mockDataSource.getAllTechnicians()).called(1);
      });
    });

    // test('should get all technicians and map models to entities', () async {
    //   final technicianModel = TechnicianModel(
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
    //   when(mockDataSource.getAllTechnicians()).thenAnswer((_) async => right([technicianModel]));
    //
    //   final result = await repository.getAllTechnicians();
    //
    //   expect(result.isRight(), isTrue);
    //   result.fold(
    //         (error) => fail('Expected right, got left: $error'),
    //         (entities) {
    //       expect(entities, hasLength(1));
    //       expect(entities.first.id, technicianModel.id);
    //       expect(entities.first.title, technicianModel.title);
    //     },
    //   );
    //   verify(mockDataSource.getAllTechnicians()).called(1);
    // });
    //
    // test('should return error when data source fails', () async {
    //   when(mockDataSource.getAllTechnicians()).thenAnswer((_) async => left(DatabaseFailure('Database error')));
    //
    //   final result = await repository.getAllTechnicians();
    //
    //   expect(result, left(DatabaseFailure('Database error')));
    //   verify(mockDataSource.getAllTechnicians()).called(1);
    // });
  });
}