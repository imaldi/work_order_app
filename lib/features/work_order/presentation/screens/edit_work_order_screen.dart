// lib/presentation/pages/edit_work_order_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:work_order_app/core/utils/extensions/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/presentation/bloc/technician_bloc.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'package:work_order_app/features/work_order_group/presentation/bloc/work_order_group_bloc.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/router/router.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../maps/presentation/state_management/location_cubit.dart';
import '../../../technician/domain/entity/technician_entity.dart';
import '../../../work_order_group/domain/entity/work_order_group_entity.dart';
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
        BlocProvider.value(value: getIt<WorkOrderBloc>()),
        BlocProvider.value(value: getIt<TechnicianBloc>()),
        BlocProvider.value(value: getIt<WorkOrderGroupBloc>()),
        BlocProvider.value(
          value: getIt<LocationCubit>()
            ..updateSelectedCoordinate(workOrder.latitude, workOrder.longitude),
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
  final _locationController = TextEditingController();
  final _reqMaterialsController = TextEditingController();
  late WorkOrderPriority _priority;
  late WorkOrderStatus _status;
  late DateTime _dueDate;
  DateTime? _scheduledStart;
  DateTime? _scheduledEnd;
  TechnicianEntity? _assignedTechnician;
  WorkOrderGroupEntity? _assignedGroup;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.workOrder.title;
    _descriptionController.text = widget.workOrder.description;
    _reqMaterialsController.text = widget.workOrder.materials;
    _addressController.text = widget.workOrder.address;
    _locationController.text = widget.workOrder.location;
    _priority = WorkOrderPriority.values.firstWhere(
      (priority) => priority.value == widget.workOrder.priority,
      orElse: () => WorkOrderPriority.low, // Default jika tidak ditemukan
    );
    _status = WorkOrderStatus.values.firstWhere(
      (priority) => priority.value == widget.workOrder.status,
      orElse: () => WorkOrderStatus.pending, // Default jika tidak ditemukan
    );
    _dueDate = widget.workOrder.dueDate.isNotEmpty
        ? DateFormat('yy-MM-dd').parse(widget.workOrder.dueDate)
        : DateTime.now();
    var nowTime = DateTime.now();
    _scheduledStart = widget.workOrder.scheduledStart.isNotEmpty
        ? DateFormat('yy-MM-dd HH:mm').parse(widget.workOrder.scheduledStart)
        : DateTime.now();
    _scheduledEnd = widget.workOrder.scheduledEnd.isNotEmpty
        ? DateFormat('yy-MM-dd HH:mm').parse(widget.workOrder.scheduledEnd)
        : DateTime.now();
    // _assignedTechnician = null;
    var tecnisianId = widget.workOrder.technicianId;
    var groupId = widget.workOrder.groupId;
    print("_assignedTechnician id: ${tecnisianId}");
    _assignedTechnician = context.read<TechnicianBloc>().state.whenOrNull(
      loaded: (list) => list.firstWhere(
        (e) => e.id == tecnisianId,
        orElse: () => TechnicianEntity(id: 0, name: "Technician Not Found"),
      ),
    );
    _assignedGroup = context.read<WorkOrderGroupBloc>().state.whenOrNull(
      loaded: (list) => list.firstWhere(
        (e) => e.id == groupId,
        orElse: () => WorkOrderGroupEntity(
          id: 0,
          title: "Work Order Group Not Found",
          description: '',
          createdAt: '',
          createdBy: 0,
        ),
      ),
    );
    print("_assignedTechnician: ${_assignedTechnician}");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _reqMaterialsController.dispose();
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
                  validator: (value) => value!.isEmpty ? 'Judul wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 5,
                  validator: (value) => value!.isEmpty ? 'Deskripsi wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<WorkOrderPriority>(
                  value: _priority,
                  decoration: const InputDecoration(labelText: 'Prioritas'),
                  items: WorkOrderPriority.values
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name.capitalize())))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _priority = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reqMaterialsController,
                  decoration: const InputDecoration(labelText: 'Material yang diperlukan'),
                  maxLines: 4,
                  validator: (value) => value!.isEmpty ? 'Material wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      loading: (l) {
                        _addressController.text = "Loading...";
                      },
                      success: (s) {
                        _addressController.text = s.currentAddress ?? "";
                      },
                      successSelectLocation: (s) {
                        _addressController.text = s.currentAddress ?? "";
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        context.router.push(MapsRoute());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Column(
                                children: [
                                  Icon(Icons.remove_red_eye, size: 32),
                                  SizedBox(height: 8),
                                  Text("Ubah", style: MyTextStyles.titleMedium),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  labelText: 'Alamat',
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                                maxLines: 4,
                                validator: (value) => value!.isEmpty ? 'Alamat wajib diisi' : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Lokasi'),
                  maxLines: 5,
                  validator: (value) => value!.isEmpty ? 'Lokasi wajib diisi' : null,
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
                        _scheduledStart = _scheduledStart?.copyWith(
                          year: _dueDate.year,
                          month: _dueDate.month,
                          day: _dueDate.day,
                        );
                        _scheduledEnd = _scheduledEnd?.copyWith(
                          year: _dueDate.year,
                          month: _dueDate.month,
                          day: _dueDate.day,
                        );
                      });
                    }
                  },
                  child: Text('Jatuh Tempo: ${_dueDate.toString().substring(0, 10)}'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    var baseDateTime = _scheduledStart ?? DateTime.now();
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: baseDateTime.hour, minute: baseDateTime.minute),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _scheduledStart = baseDateTime.copyWith(
                          hour: selectedTime.hour,
                          minute: selectedTime.minute,
                        );
                      });
                    }
                  },
                  child: Text(
                    _scheduledStart == null
                        ? 'Pilih Waktu Mulai Tugas'
                        : 'Waktu Mulai: ${DateFormat("HH:mm").format(_scheduledStart!)}',
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    var baseDateTime = _scheduledEnd ?? DateTime.now();
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: baseDateTime.hour, minute: baseDateTime.minute),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _scheduledEnd = baseDateTime.copyWith(
                          hour: selectedTime.hour,
                          minute: selectedTime.minute,
                        );
                      });
                    }
                  },
                  child: Text(
                    _scheduledEnd == null
                        ? 'Pilih Waktu Selesai Tugas'
                        : 'Waktu Selesai: ${DateFormat("HH:mm").format(_scheduledEnd!)}',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<WorkOrderStatus>(
                  value: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: WorkOrderStatus.values
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name.capitalize())))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                BlocConsumer<TechnicianBloc, TechnicianState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return state.whenOrNull(
                          loading: () {
                            return const CircularProgressIndicator();
                          },
                          loaded: (list) {
                            return InkWell(
                              onTap: list.isNotEmpty ? null : (){
                                Fluttertoast.showToast(
                                    msg: "Harap buat dulu technician di halaman pengaturan",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.lightBlue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: DropdownButtonFormField<TechnicianEntity>(
                                value: (_assignedTechnician?.id ?? 0) != 0
                                    ? _assignedTechnician
                                    : null,
                                decoration: const InputDecoration(labelText: 'Teknisi'),
                                items: list
                                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _assignedTechnician = value;
                                  });
                                },
                              ),
                            );
                          },
                        ) ??
                        SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 16),
                BlocBuilder<WorkOrderGroupBloc, WorkOrderGroupState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                          loading: () {
                            return const CircularProgressIndicator();
                          },
                          loaded: (list) {
                            return InkWell(
                              onTap: list.isNotEmpty ? null : (){
                                Fluttertoast.showToast(
                                    msg: "Harap buat dulu group di halamannya",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.lightBlue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: DropdownButtonFormField<WorkOrderGroupEntity>(
                                value: _assignedGroup,
                                decoration: const InputDecoration(labelText: 'Group'),
                                items: list
                                    .map((e) => DropdownMenuItem(value: e, child: Text(e.title)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _assignedGroup = value;
                                  });
                                },
                              ),
                            );
                          },
                        ) ??
                        SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    (double, double) selectedPoint =
                        state.whenOrNull(
                          successSelectLocation: (res) => (res.latitude, res.longitude),
                          success: (res) => (res.latitude, res.longitude),
                        ) ??
                        (0.0, 0.0);
                    String selectedAdress =
                        state.whenOrNull(
                          successSelectLocation: (res) => res.currentAddress,
                          success: (res) => res.currentAddress,
                        ) ??
                        "";
                    return BlocConsumer<WorkOrderBloc, WorkOrderState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          loading: () {
                            EasyLoading.show(status: "Loading Address", dismissOnTap: true);
                          },
                          error: (failure) {
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(
                              msg: "Gagal membuat Work Order: ${failure.message}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.lightBlue,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          loaded: (list) {
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(
                              msg: "Berhasil membuat Work Order",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.lightBlue,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          orElse: () {},
                        );
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO Baikin ini nanti pagi
                              final updatedWorkOrder = widget.workOrder.copyWith(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                priority: _priority.value,
                                address: _addressController.text,
                                latitude: selectedPoint.$1, // Default value
                                longitude: selectedPoint.$2, // Default value
                                dueDate: DateFormat("yy-MM-dd").format(_dueDate),
                                status: _status.value,
                                technicianId: _assignedTechnician?.id ?? 0,
                                groupId: _assignedGroup?.id ?? 0,
                                createdAt: DateFormat("yy-MM-dd HH:mm").format(DateTime.now()),
                                customId: _titleController.text,
                                materials: _reqMaterialsController.text,
                                photoPath: '',
                                attachmentPath: '',
                                // TODO: Pastikan scheduledEnd > scheduledStart
                                scheduledStart: _scheduledStart != null
                                    ? DateFormat("yy-MM-dd HH:mm").format(
                                        _dueDate!.copyWith(
                                          hour: _scheduledStart?.hour ?? 0,
                                          minute: _scheduledStart?.minute ?? 0,
                                        ),
                                      )
                                    : "",
                                scheduledEnd: _scheduledEnd != null
                                    ? DateFormat("yy-MM-dd HH:mm").format(
                                        _dueDate!.copyWith(
                                          hour: _scheduledEnd?.hour ?? 0,
                                          minute: _scheduledStart?.minute ?? 0,
                                        ),
                                      )
                                    : "",
                                location: _locationController.text,
                              );
                              context.read<WorkOrderBloc>().add(
                                UpdateWorkOrderEvent(
                                  UpdateWorkOrdersParams(workOrderEntity: updatedWorkOrder),
                                ),
                              );
                              context.router.pop();
                            }
                          },
                          child: const Text('Simpan'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
