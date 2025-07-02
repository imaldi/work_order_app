import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Text('JD', style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 16.0),
            const Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Field Technician', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16.0),
            _buildStatRow('Completed', 24),
            _buildStatRow('Rating', 4.8, isRating: true),
            _buildStatRow('In Progress', 3),
            const SizedBox(height: 16.0),
            _buildInfoRow('Email', 'john.doe@fieldconnect.com'),
            _buildInfoRow('Phone', '(555) 987-6543'),
            _buildInfoRow('Position', 'Senior Field Technician'),
            _buildInfoRow('Department', 'Facilities Maintenance'),
            const SizedBox(height: 16.0),
            const Text('Skills & Certifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            _buildSkillRow('Skills', 'HVAC, Electrical, Plumbing'),
            _buildSkillRow('Certifications', 'OSHA Certified, CPR Trained'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, dynamic value, {bool isRating = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(isRating ? '$value/5' : value.toString()),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSkillRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

