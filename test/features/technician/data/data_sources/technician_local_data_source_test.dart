import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:work_order_app/core/errors/failures.dart';
import 'package:work_order_app/core/helpers/database_helper.dart';
import 'package:work_order_app/features/technician/data/data_sources/technician_local_data_source.dart';
import 'package:work_order_app/features/technician/data/model/technician_model.dart';

void main() {
  late DatabaseHelper databaseHelper;
  late TechnicianLocalDataSourceImpl dataSource;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    TestWidgetsFlutterBinding.ensureInitialized();
    databaseHelper = DatabaseHelper();
    dataSource = TechnicianLocalDataSourceImpl(databaseHelper);
  });

  tearDownAll(() async {
    final db = await databaseHelper.database;
    await db.close();
  });

  group('TechnicianLocalDataSourceImpl - Database Operations', () {
    final technician = TechnicianModel(
      id: 1,
      name: 'Aldi',
      contact: '082233445566',
    );

    test('should add technician to database', () async {
      final result = await dataSource.addTechnician(technician);
      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final techniciansResult = await dataSource.getAllTechnicians();
      expect(techniciansResult.isRight(), isTrue);
      expect(techniciansResult.getOrElse((l) => []), hasLength(1));
      expect(techniciansResult.getOrElse((l) => []).first.name, 'Aldi');
    });

    test('should edit technician in database', () async {
      await dataSource.addTechnician(technician);
      final updatedTechnician = technician.copyWith(
        name: 'Aldi Majid',
        contact: '082244448888',
      );

      final result = await dataSource.updateTechnician(updatedTechnician);

      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final techniciansResult = await dataSource.getAllTechnicians();
      expect(techniciansResult.isRight(), isTrue);
      expect(techniciansResult.getOrElse((l) => []), hasLength(1));
      expect(techniciansResult.getOrElse((l) => []).first.name, 'Aldi Majid');
    });

    test('should delete technician from database', () async {
      await dataSource.addTechnician(technician);

      final result = await dataSource.deleteTechnician(technician.id);

      expect(result.isRight(), isTrue);
      expect(result, right(unit));

      final techniciansResult = await dataSource.getAllTechnicians();
      expect(techniciansResult.isRight(), isTrue);
      expect(techniciansResult.getOrElse((l) => []), hasLength(0));
    });

    test('should return error when technician not found for deletion', () async {
      final result = await dataSource.deleteTechnician(999);

      expect(result.isLeft(), isTrue);
      result.fold(
            (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect(failure.message, 'Technician not found');
        },
            (unit) => fail('Expected Left, but got Right'),
      );
    });

    //   Pertimbangkan menambahkan test case untuk skenario lain, seperti:
    //
    //     Menambahkan TechnicianModel dengan field null (jika diperbolehkan).
    //     Mengedit TechnicianModel yang tidak ada (harus return Left dengan pesan error).
    //     Mengambil getAllTechnicians saat database kosong (harus return Right dengan list kosong).

    //     contoh edge cases
    test('should return empty list when no technicians exist', () async {
      final techniciansResult = await dataSource.getAllTechnicians();
      expect(techniciansResult.isRight(), isTrue);
      expect(techniciansResult.getOrElse((l) => []), isEmpty);
    });
  });

}