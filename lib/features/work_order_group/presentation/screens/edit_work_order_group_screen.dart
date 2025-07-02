import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';
import 'package:work_order_app/features/technician/presentation/bloc/technician_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../domain/entity/work_order_group_entity.dart';
import '../bloc/work_order_group_bloc.dart';

@RoutePage()
class EditWorkOrderGroupScreen extends StatefulWidget implements AutoRouteWrapper {
  final WorkOrderGroupEntity group;

  const EditWorkOrderGroupScreen({super.key, required this.group});

  @override
  State<EditWorkOrderGroupScreen> createState() => _EditWorkOrderGroupScreenState();

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

class _EditWorkOrderGroupScreenState extends State<EditWorkOrderGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TechnicianEntity? _creator;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.group.title;
    _descriptionController.text = widget.group.description ?? '';
    var creatorId = widget.group.createdBy;
    print("_assignedTechnician id: ${creatorId}");
    _creator = context.read<TechnicianBloc>().state.whenOrNull(loaded: (list) => list.firstWhere((e) => e.id == creatorId, orElse: ()=> TechnicianEntity(id: 0, name: "Technician Not Found")));
    print("_assignedTechnician: ${_creator}");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Work Order Group')),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedWorkOrderGroup = WorkOrderGroupEntity(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          createdAt: DateFormat("yy-MM-dd HH:mm").format(DateTime.now()),
                          createdBy: _creator?.id ?? 0,
                          id: widget.group.id,
                        );
                        context
                            .read<WorkOrderGroupBloc>()
                            .add(UpdateWorkOrderGroupEvent(
                            CreateEntityParams(
                              entity: updatedWorkOrderGroup
                            )
                        ));
                        context.router.pop();
                      }
                    },
                    child: const Text('Simpan'),
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