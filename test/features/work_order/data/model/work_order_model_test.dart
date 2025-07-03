import 'package:flutter_test/flutter_test.dart';
import 'package:work_order_app/features/work_order/data/model/work_order_model.dart';

void main() {
  group('WorkOrderModel', () {
    test('should serialize to JSON correctly', () {
      final workOrder = WorkOrderModel(
        id: 1,
        title: 'Fix AC',
        description: 'Repair air conditioner',
        priority: 'High',
        status: 'Pending',
        technicianId: 1,
        address: 'Jl. Contoh No. 123',
        latitude: -6.2,
        longitude: 106.8,
        dueDate: '2025-07-01 00:00',
        createdAt: '2025-06-01 00:00', customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '', groupId: 0,
      );

      final json = workOrder.toJson();
      expect(json['id'], 1);
      expect(json['title'], 'Fix AC');
      expect(json['latitude'], -6.2);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 1,
        'title': 'Fix AC',
        'description': 'Repair air conditioner',
        'priority': 'High',
        'status': 'Pending',
        'dueDate': '2025-07-01',
        'technicianId': 1,
        'address': 'Jl. Contoh No. 123',
        'latitude': -6.2,
        'longitude': 106.8,
      //   TODO lengkappi field2 json nya
      };

      final workOrder = WorkOrderModel.fromJson(json);
      expect(workOrder.id, 1);
      expect(workOrder.title, 'Fix AC');
      expect(workOrder.latitude, -6.2);
    });

    test('should compare equal objects correctly', () {
      final workOrder1 = WorkOrderModel(
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
        longitude: 106.8, customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '', groupId: 0,
      );

      final workOrder2 = WorkOrderModel(
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
        longitude: 106.8, customId: '', materials: '', photoPath: '', attachmentPath: '', scheduledStart: '', scheduledEnd: '', location: '', groupId: 0,
      );

      expect(workOrder1, workOrder2);
    });
  });
}