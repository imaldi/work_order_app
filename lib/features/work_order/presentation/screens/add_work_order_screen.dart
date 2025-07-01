import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/utils/extensions/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../../core/injection/injection.dart';
import '../../../technician/presentation/bloc/technician_bloc.dart';


@RoutePage()
class AddWorkOrderScreen extends StatefulWidget implements AutoRouteWrapper  {
  const AddWorkOrderScreen({Key? key}) : super(key: key);

  @override
  State<AddWorkOrderScreen> createState() => _AddWorkOrderScreenState();

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

class _AddWorkOrderScreenState extends State<AddWorkOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  WorkOrderPriority _priority = WorkOrderPriority.low;
  WorkOrderStatus _status = WorkOrderStatus.pending;
  DateTime? _dueDate;
  String? _assignedTechnicianId;

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
      appBar: AppBar(title: const Text('Tambah Work Order')),
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
                      initialDate: DateTime.now(),
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
                    _dueDate == null
                        ? 'Pilih Tanggal Jatuh Tempo'
                        : 'Jatuh Tempo: ${_dueDate!.toString().substring(0, 10)}',
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
                // TODO: Nanti pagi baikin
                // BlocBuilder<TechnicianBloc, TechnicianState>(
                //   builder: (context, state) {
                //
                //     if (state is TechnicianLoaded) {
                //       return DropdownButtonFormField<String>(
                //         value: _assignedTechnicianId,
                //         decoration: const InputDecoration(labelText: 'Teknisi'),
                //         items: state.technicians
                //             .map((e) => DropdownMenuItem(
                //           value: e.id,
                //           child: Text(e.name),
                //         ))
                //             .toList(),
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _dueDate != null) {
                      // final workOrder = WorkOrderEntity(
                      //   id: '', // ID akan di-generate oleh repository
                      //   title: _titleController.text,
                      //   description: _descriptionController.text,
                      //   priority: _priority,
                      //   address: _addressController.text,
                      //   latitude: 0.0, // Default value
                      //   longitude: 0.0, // Default value
                      //   dueDate: _dueDate!,
                      //   status: _status,
                      //   assignedTechnicianId: _assignedTechnicianId,
                      // );
                      // context.read<WorkOrderBloc>().add(AddWorkOrderEvent(
                      //     AddWorkOrdersParams(
                      //       workOrderEntity: workOrder,
                      //     )
                      // ));
                      context.router.pop();
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}