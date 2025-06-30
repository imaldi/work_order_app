import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/params/technician_params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';
import 'package:work_order_app/features/technician/domain/use_cases/add_technician.dart';
import 'package:work_order_app/features/technician/domain/use_cases/delete_technician.dart';
import 'package:work_order_app/features/technician/domain/use_cases/get_all_technicians.dart';
import 'package:work_order_app/features/technician/domain/use_cases/update_technician.dart';
import 'package:work_order_app/features/technician/presentation/bloc/technician_bloc.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';
import 'technician_bloc_test.mocks.dart';

@GenerateMocks([
  AddTechnician,
  GetAllTechnicians,
  UpdateTechnician,
  DeleteTechnician,
])
void main() {
  late TechnicianBloc bloc;
  late MockAddTechnician mockAddTechnician;
  late MockGetAllTechnicians mockLoadTechnicians;
  late MockUpdateTechnician mockUpdateTechnician;
  late MockDeleteTechnician mockDeleteTechnician;

  setUp(() {
    // Menyediakan dummy value untuk Either<String, List<TechnicianModel>>
    provideDummy<Either<Failure, List<TechnicianEntity>>>(left(DatabaseFailure('Dummy error')));
    provideDummy<Either<Failure, Unit>>(left(DatabaseFailure('Dummy error')));

    mockAddTechnician = MockAddTechnician();
    mockLoadTechnicians = MockGetAllTechnicians();
    mockUpdateTechnician = MockUpdateTechnician();
    mockDeleteTechnician = MockDeleteTechnician();
    bloc = TechnicianBloc(
        mockLoadTechnicians,
        mockAddTechnician,
        mockUpdateTechnician,
        mockDeleteTechnician,
    );
  });

  final tTechnician = TechnicianEntity(id: 1, name: 'Aldi', contact: "082233445566");
  final tTechnicians = [tTechnician];
  final tFailure = DatabaseFailure('Operation failed');

  group('TechnicianBloc', () {
    test('initial state should be TechnicianInitial', () {
      expect(bloc.state, TechnicianInitial());
    });

    group('LoadTechniciansEvent', () {
      test('should emit [TechnicianLoaded] when load succeeds', () async {
        // Arrange
        // ini sediakan stub nya
        when(mockLoadTechnicians(any))
            .thenAnswer((_) async => Right(tTechnicians));
        // Act
        bloc.add(const LoadTechniciansEvent());
        await untilCalled(mockLoadTechnicians(any));
        // Assert
        expectLater(
          bloc.stream,
          emitsInOrder([
            TechnicianLoaded(tTechnicians),
          ]),
        );
        verify(mockLoadTechnicians(any)).called(1);
      });

      test('should emit [TechnicianError] when load fails', () async {
        // Arrange
        when(mockLoadTechnicians(any))
            .thenAnswer((_) async => Left(tFailure));
        // Act
        bloc.add(const LoadTechniciansEvent());
        await untilCalled(mockLoadTechnicians(any));
        // Assert
        expectLater(
          bloc.stream,
          emitsInOrder([
            TechnicianError(tFailure),
          ]),
        );
        verify(mockLoadTechnicians(any)).called(1);
      });
    });
  });

  group('AddTechnicianEvent', () {
    final params = AddTechnicianParams(technicianEntity: tTechnician);

    blocTest<TechnicianBloc, TechnicianState>(
      'emits [loading, loaded] when add succeeds',
      setUp: () {
        when(mockAddTechnician(params)).thenAnswer((_) async => Right(unit));
        when(mockLoadTechnicians(any)).thenAnswer((_) async => Right(tTechnicians));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(AddTechnicianEvent(params)),
      expect: () => [
        const TechnicianState.loading(),
        TechnicianState.loaded(tTechnicians),
      ],
      verify: (_) {
        verify(mockAddTechnician(params)).called(1);
        verify(mockLoadTechnicians(any)).called(1);
      },
    );


    blocTest<TechnicianBloc, TechnicianState>(
      'emits [loading, error] when add fails',
      setUp: () {
        when(mockAddTechnician(params)).thenAnswer((_) async => Left(tFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(AddTechnicianEvent(params)),
      expect: () => [
        const TechnicianState.loading(),
        TechnicianState.error(tFailure),
      ],
      verify: (_) {
        verify(mockAddTechnician(params)).called(1);
        verifyNever(mockLoadTechnicians(any));
      },
    );
  });

  group('UpdateTechnicianEvent', () {
    final updatedTechnician = tTechnician.copyWith(name: "Aldi Majid");

    final updateTparams = UpdateTechnicianParams(technicianEntity: updatedTechnician);

    final updatedTechnicians = [
      updatedTechnician
    ];
    blocTest<TechnicianBloc, TechnicianState>(
      'emits [loading, loaded] when update succeeds',
      setUp: () {
        when(mockUpdateTechnician(updateTparams)).thenAnswer((_) async => Right(unit));
        when(mockLoadTechnicians(any)).thenAnswer((_) async => Right(updatedTechnicians));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(UpdateTechnicianEvent(updateTparams));
      },
      expect: () => [
        const TechnicianState.loading(),
        TechnicianState.loaded(updatedTechnicians),
      ],
      verify: (_) {
        verify(mockUpdateTechnician(updateTparams)).called(1);
        verify(mockLoadTechnicians(any)).called(1);
      },
    );
    blocTest<TechnicianBloc, TechnicianState>(
      'emits [loading, error] when update fails',
      setUp: () {
        when(mockUpdateTechnician(updateTparams)).thenAnswer((_) async => Left(tFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(UpdateTechnicianEvent(updateTparams)),
      expect: () => [
        const TechnicianState.loading(),
        TechnicianState.error(tFailure),
      ],
      verify: (_) {
        verify(mockUpdateTechnician(updateTparams)).called(1);
        verifyNever(mockLoadTechnicians(any));
      },
    );
  });

  group('DeleteTechnicianEvent', () {
    final params = DeleteTechnicianParams(id: tTechnician.id);

    blocTest<TechnicianBloc, TechnicianState>(
      'emits [loading, loaded] when delete succeeds',
      setUp: () {
        when(mockDeleteTechnician(params)).thenAnswer((_) async => Right(unit));
        when(mockLoadTechnicians(any)).thenAnswer((_) async => Right([]));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(DeleteTechnicianEvent(params)),
      expect: () => [
        const TechnicianState.loading(),
        TechnicianState.loaded([]),
      ],
      verify: (_) {
        verify(mockDeleteTechnician(params)).called(1);
        verify(mockLoadTechnicians(any)).called(1);
      },
    );


    blocTest<TechnicianBloc, TechnicianState>(
      'emits [loading, error] when delete fails',
      setUp: () {
        when(mockDeleteTechnician(params)).thenAnswer((_) async => Left(tFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(DeleteTechnicianEvent(params)),
      expect: () => [
        const TechnicianState.loading(),
        TechnicianState.error(tFailure),
      ],
      verify: (_) {
        verify(mockDeleteTechnician(params)).called(1);
        verifyNever(mockLoadTechnicians(any));
      },
    );
  });

  // Tambah test serupa untuk UpdateTechnicianEvent, DeleteTechnicianEvent, dll.
  // group('SearchTechniciansEvent', () {
  //   final params = SearchTechniciansParams(query: 'Aldi');
  //   test('should emit [TechnicianLoaded] when search succeeds', () async {
  //     // Arrange
  //     when(mockSearchTechnicians(params))
  //         .thenAnswer((_) async => Right(tTechnicians));
  //     // Act
  //     bloc.add(SearchTechniciansEvent(params));
  //     await untilCalled(mockSearchTechnicians(params));
  //     // Assert
  //     expectLater(
  //       bloc.stream,
  //       emitsInOrder([
  //         TechnicianLoaded(tTechnicians),
  //       ]),
  //     );
  //     verify(mockSearchTechnicians(params)).called(1);
  //   });
  //
  //   test('should emit [TechnicianError] when search fails', () async {
  //     // Arrange
  //     when(mockSearchTechnicians(params))
  //         .thenAnswer((_) async => Left(tFailure));
  //     // Act
  //     bloc.add(SearchTechniciansEvent(params));
  //     await untilCalled(mockSearchTechnicians(params));
  //     // Assert
  //     expectLater(
  //       bloc.stream,
  //       emitsInOrder([
  //         TechnicianError(tFailure),
  //       ]),
  //     );
  //     verify(mockSearchTechnicians(params)).called(1);
  //   });
  // });


  /// ini tes awal
  blocTest<TechnicianBloc, TechnicianState>(
    'emits [loading, loaded] when LoadTechniciansEvent is added and getAllTechnicians succeeds',
    setUp: () {
      provideDummy<Either<String, List<TechnicianEntity>>>(left('Dummy error'));
      when(mockLoadTechnicians(any)).thenAnswer((_) async => right([
        tTechnician
      ]));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(const LoadTechniciansEvent()),
    expect: () => [
      const TechnicianState.loading(),
      TechnicianState.loaded([
        tTechnician
      ]),
    ],
  );
}