// lib/presentation/pages/edit_technician_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/params/technician_params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';

import '../../../../core/injection/injection.dart';
import '../bloc/technician_bloc.dart';

@RoutePage()
class EditTechnicianScreen extends StatefulWidget implements AutoRouteWrapper {
  final TechnicianEntity technician;

  const EditTechnicianScreen({super.key, required this.technician});

  @override
  State<EditTechnicianScreen> createState() => _EditTechnicianScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
        value: getIt<TechnicianBloc>(),
        child: this);
  }
}

class _EditTechnicianScreenState extends State<EditTechnicianScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.technician.name;
    _phoneController.text = widget.technician.contact ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Teknisi')),
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
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value!.isEmpty ? 'Kontak wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedTechnician = widget.technician.copyWith(
                          name: _nameController.text,
                          contact: _phoneController.text,
                        );
                        context
                            .read<TechnicianBloc>()
                            .add(UpdateTechnicianEvent(
                            UpdateTechnicianParams(
                              technicianEntity: updatedTechnician
                            )
                        ));
                        context.router.pop();
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<TechnicianBloc>()
                          .add(DeleteTechnicianEvent(
                          DeleteTechnicianParams(
                            id: widget.technician.id
                          )
                      ));
                      context.router.pop();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}