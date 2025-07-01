// lib/presentation/pages/edit_work_order_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/presentation/bloc/technician_bloc.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../../core/injection/injection.dart';
import '../bloc/work_order_bloc.dart';

@RoutePage()
class EditWorkOrderScreen extends StatefulWidget implements AutoRouteWrapper {
  final WorkOrderEntity workOrder;

  const EditWorkOrderScreen({Key? key, required this.workOrder}) : super(key: key);

  @override
  State<EditWorkOrderScreen> createState() => _EditWorkOrderScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: getIt<WorkOrderBloc>(),
            ),
        BlocProvider.value(
            value: getIt<TechnicianBloc>(),
            ),
      ],
        child: this,
    );
  }
}

class _EditWorkOrderScreenState extends State<EditWorkOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  late WorkOrderPriority _priority;
  late WorkOrderStatus _status;
  late DateTime _dueDate;
  String? _assignedTechnicianId;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.workOrder.title;
    _descriptionController.text = widget.workOrder.description;
    _addressController.text = widget.workOrder.address;
    // _priority = widget.workOrder.priority;
    // _status = widget.workOrder.status;
    // _dueDate = widget.workOrder.dueDate;
    // _assignedTechnicianId = widget.workOrder.assignedTechnicianId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Work Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Judul'),
                  validator: (value) =>
                  value!.isEmpty ? 'Judul wajib diisi' : null,
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
                DropdownButtonFormField<WorkOrderPriority>(
                  value: _priority,
                  decoration: const InputDecoration(labelText: 'Prioritas'),
                  items: WorkOrderPriority.values
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name.capitalize()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _priority = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                  maxLines: 5,
                  validator: (value) =>
                  value!.isEmpty ? 'Alamat wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _dueDate = selectedDate;
                      });
                    }
                  },
                  child: Text(
                    'Jatuh Tempo: ${_dueDate.toString().substring(0, 10)}',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<WorkOrderStatus>(
                  value: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: WorkOrderStatus.values
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name.capitalize()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // TODO: nanti pagi baikin
                // BlocBuilder<TechnicianBloc, TechnicianState>(
                //   builder: (context, state) {
                //     if (state is TechnicianLoaded) {
                //       return DropdownButtonFormField<String>(
                //         value: _assignedTechnicianId,
                //         decoration: const InputDecoration(labelText: 'Teknisi'),
                //         items: [
                //           const DropdownMenuItem<String>(
                //             value: null,
                //             child: Text('Tidak Ditugaskan'),
                //           ),
                //           ...state.technicians
                //               .map((e) => DropdownMenuItem(
                //             value: e.id,
                //             child: Text(e.name),
                //           ))
                //               .toList(),
                //         ],
                //         onChanged: (value) {
                //           setState(() {
                //             _assignedTechnicianId = value;
                //           });
                //         },
                //       );
                //     }
                //     return const CircularProgressIndicator();
                //   },
                // ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO Baikin ini nanti pagi
                          // final updatedWorkOrder = widget.workOrder.copyWith(
                          //   title: _titleController.text,
                          //   description: _descriptionController.text,
                          //   priority: _priority,
                          //   address: _addressController.text,
                          //   latitude: widget.workOrder.latitude,
                          //   longitude: widget.workOrder.longitude,
                          //   dueDate: _dueDate,
                          //   status: _status,
                          //   assignedTechnicianId: _assignedTechnicianId,
                          // );
                          // context
                          //     .read<WorkOrderBloc>()
                          //     .add(UpdateWorkOrderEvent(
                          //     UpdateWorkOrdersParams(
                          //       workOrderEntity: updatedWorkOrder,
                          //     )
                          // ));
                          // context.router.pop();
                        }
                      },
                      child: const Text('Simpan'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<WorkOrderBloc>()
                            .add(DeleteWorkOrderEvent(
                            DeleteWorkOrdersParams(
                              id: widget.workOrder.id
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
      ),
    );
  }
}