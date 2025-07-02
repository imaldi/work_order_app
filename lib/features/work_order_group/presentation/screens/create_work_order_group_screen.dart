import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_order_app/core/params/params.dart';

import '../../../../core/injection/injection.dart';
import '../../../../core/params/technician_params.dart';
import '../../../technician/domain/entity/technician_entity.dart';
import '../../../technician/presentation/bloc/technician_bloc.dart';
import '../../domain/entity/work_order_group_entity.dart';
import '../bloc/work_order_group_bloc.dart';

@RoutePage()
class CreateWorkOrderGroupScreen extends StatefulWidget implements AutoRouteWrapper  {
  const CreateWorkOrderGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkOrderGroupScreen> createState() => _CreateWorkOrderGroupScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: getIt<WorkOrderGroupBloc>()),
        BlocProvider.value(
            value: getIt<TechnicianBloc>()..add(LoadTechniciansEvent())),
      ],
      child: this,
    );
  }
}

class _CreateWorkOrderGroupScreenState extends State<CreateWorkOrderGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TechnicianEntity? _creator;
  

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Work Order Group')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) =>
                value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 5,
                validator: (value) =>
                value!.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              BlocBuilder<TechnicianBloc, TechnicianState>(
                builder: (context, state) {
                  return state.whenOrNull(
                      loading: (){
                        return const CircularProgressIndicator();
                      },
                      loaded: (list){
                        return DropdownButtonFormField<TechnicianEntity>(
                          value: _creator,
                          decoration: const InputDecoration(labelText: 'Work Order Group'),
                          items: list
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _creator = value;
                            });
                          },
                        );
                      }

                  ) ?? SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final group = WorkOrderGroupEntity(
                      id: 0, // ID di-generate oleh repository
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdAt: DateFormat("yy-MM-dd HH:mm").format(DateTime.now()),
                      createdBy: _creator?.id ?? 0,
                    );
                    context.read<WorkOrderGroupBloc>().add(CreateWorkOrderGroupEvent(
                        CreateEntityParams(
                          entity: group,
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