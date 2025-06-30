import 'package:flutter_test/flutter_test.dart';
import 'package:work_order_app/features/technician/data/model/technician_model.dart';

void main() {
  group('TechnicianModel', () {
    test('should serialize to JSON correctly', () {
      final technician = TechnicianModel(
        id: 1,
        name: 'Aldi',
        contact: '082233445566',
      );

      final json = technician.toJson();
      expect(json['id'], 1);
      expect(json['name'], 'Aldi');
      expect(json['contact'], '082233445566');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 1,
        'name': 'Aldi',
        'contact': '082233445566',
      };

      final technician = TechnicianModel.fromJson(json);
      expect(technician.id, 1);
      expect(technician.name, 'Aldi');
      expect(technician.contact, "082233445566");
    });

    test('should compare equal objects correctly', () {
      final technician1 = TechnicianModel(
        id: 1,
        name: 'Aldi',
        contact: '082233445566',
      );

      final technician2 = TechnicianModel(
        id: 1,
        name: 'Aldi',
        contact: '082233445566',
      );

      expect(technician1, technician2);
    });
  });
}