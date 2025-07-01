// lib/presentation/Screens/add_technician_Screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../../../core/params/technician_params.dart';
import '../../domain/entity/technician_entity.dart';
import '../bloc/technician_bloc.dart';

@RoutePage()
class AddTechnicianScreen extends StatefulWidget implements AutoRouteWrapper  {
  const AddTechnicianScreen({Key? key}) : super(key: key);

  @override
  State<AddTechnicianScreen> createState() => _AddTechnicianScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
        value: getIt<TechnicianBloc>(),
        child: this);
  }
}

class _AddTechnicianScreenState extends State<AddTechnicianScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Teknisi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) =>
                value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) =>
                value!.isEmpty ? 'Kontak wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final technician = TechnicianEntity(
                      id: 0, // ID di-generate oleh repository
                      name: _nameController.text,
                      contact: _phoneController.text,
                    );
                    context.read<TechnicianBloc>().add(AddTechnicianEvent(
                        AddTechnicianParams(
                          technicianEntity: technician,
                        )
                    ));
                    context.router.pop();
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}