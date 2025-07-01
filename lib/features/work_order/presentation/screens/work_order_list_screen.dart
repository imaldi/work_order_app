import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/consts_and_enums/enums/sort_by_enum.dart';
import 'package:work_order_app/core/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../../core/injection/injection.dart';
import '../../../technician/presentation/bloc/technician_bloc.dart';
import '../../../work_order/presentation/bloc/work_order_bloc.dart';

@RoutePage()
class WorkOrderListScreen extends StatefulWidget implements AutoRouteWrapper  {
  const WorkOrderListScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();

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

class _WorkOrderListScreenState extends State<WorkOrderListScreen> {
  String _searchQuery = '';
  WorkOrderStatus? _filterStatus;
  WorkOrderPriority? _filterPriority;
  DateTimeRange? _filterDateRange;
  TechnicianEntity? _filterAssignedTechnician;
  String _sortBy = 'title'; // title, priority, dueDate
  bool _isAsc = true;

  @override
  void initState() {
    super.initState();
    context.read<WorkOrderBloc>().add(LoadWorkOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Work Order'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari Work Order...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                context.read<WorkOrderBloc>().add(
                  SearchWorkOrdersEvent(
                    SearchWorkOrdersParams(query: _searchQuery),
                    // searchQuery: _searchQuery,
                    // status: _filterStatus,
                    // priority: _filterPriority,
                    // dateRange: _filterDateRange,
                    // assignedTechnician: _filterAssignedTechnician,
                    // sortBy: _sortBy,
                    // isAsc: _isAsc,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _sortBy,
                    hint: const Text('Sort By'),
                    items: [
                      'title',
                      'priority',
                      'dueDate',
                    ].map((e) => DropdownMenuItem(value: e, child: Text(e.capitalize()))).toList(),
                    onChanged: (value) {
                      setState(() {
                        _sortBy = value!;
                      });
                      context.read<WorkOrderBloc>().add(
                        SortWorkOrdersEvent(
                          SortWorkOrdersParams(
                            sortBy: WorkOrderSortField.priority,
                            isAscending: _isAsc,
                          ),
                          // searchQuery: _searchQuery,
                          // status: _filterStatus,
                          // priority: _filterPriority,
                          // dateRange: _filterDateRange,
                          // assignedTechnician: _filterAssignedTechnician,
                          // sortBy: _sortBy,
                          // isAsc: _isAsc,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<bool>(
                    value: _isAsc,
                    hint: const Text('Order'),
                    items: [
                      const DropdownMenuItem(value: true, child: Text('Asc')),
                      const DropdownMenuItem(value: false, child: Text('Desc')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _isAsc = value!;
                      });
                      context.read<WorkOrderBloc>().add(
                        LoadWorkOrdersEvent(
                          // searchQuery: _searchQuery,
                          // status: _filterStatus,
                          // priority: _filterPriority,
                          // dateRange: _filterDateRange,
                          // assignedTechnician: _filterAssignedTechnician,
                          // sortBy: _sortBy,
                          // isAsc: _isAsc,
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => _showFilterDialog(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<WorkOrderBloc, WorkOrderState>(
              builder: (context, state) {
                // Note ini masih belum pakai map dan when
                if (state is WorkOrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WorkOrderLoaded) {
                  return ListView.builder(
                    itemCount: state.workOrders.length,
                    itemBuilder: (context, index) {
                      final wo = state.workOrders[index];
                      return ListTile(
                        title: Text(wo.title),
                        subtitle: Text('Status: ${wo.status} | Priority: ${wo.priority}'),
                        onTap: () {
                          // TODO hidupkan setelah generate route nya
                          // context.router.push(EditWorkOrderRoute(workOrder: wo));
                        },
                      );
                    },
                  );
                } else if (state is WorkOrderError) {
                  return Center(child: Text(state.failure.message));
                }
                return const Center(child: Text('Tidak ada data'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO hidupkan setelah generate route nya
          // context.router.push(const AddWorkOrderRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Work Order'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<WorkOrderStatus?>(
                  value: _filterStatus,
                  hint: const Text('Status'),
                  items: [
                    const DropdownMenuItem<WorkOrderStatus?>(
                      value: null,
                      child: Text('Semua Status'),
                    ),
                    ...WorkOrderStatus.values
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.name.capitalize())))
                        .toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _filterStatus = value;
                    });
                  },
                ),
                DropdownButton<WorkOrderPriority?>(
                  value: _filterPriority,
                  hint: const Text('Priority'),
                  items: [
                    const DropdownMenuItem<WorkOrderPriority?>(
                      value: null,
                      child: Text('Semua Priority'),
                    ),
                    ...WorkOrderPriority.values
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.name.capitalize())))
                        .toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _filterPriority = value;
                    });
                  },
                ),
                TextButton(
                  onPressed: () async {
                    final dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDateRange: _filterDateRange,
                    );
                    setState(() {
                      _filterDateRange = dateRange;
                    });
                  },
                  child: Text(
                    _filterDateRange == null
                        ? 'Pilih Rentang Tanggal'
                        : 'Tanggal: ${_filterDateRange!.start.toString().substring(0, 10)} - ${_filterDateRange!.end.toString().substring(0, 10)}',
                  ),
                ),
                // Asumsi TechnicianBloc menyediakan daftar technician
                BlocBuilder<TechnicianBloc, TechnicianState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                          loading: () => Center(child: CircularProgressIndicator()),
                          loaded: (technicianList) {
                            return DropdownButton<TechnicianEntity>(
                                  value: _filterAssignedTechnician,
                                  hint: const Text('Teknisi'),
                                  items: [
                                    const DropdownMenuItem<TechnicianEntity>(
                                      value: null,
                                      child: Text('Semua Teknisi'),
                                    ),
                                    ...technicianList.map(
                                      (e) => DropdownMenuItem<TechnicianEntity>(
                                        value: e,
                                        child: Text(e.name),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _filterAssignedTechnician = value;
                                    });
                                  },
                                )
                                as Widget;
                          },
                        ) ??
                        const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _filterStatus = null;
                  _filterPriority = null;
                  _filterDateRange = null;
                  _filterAssignedTechnician = null;
                });
                context.read<WorkOrderBloc>().add(
                  LoadWorkOrdersEvent(
                    // searchQuery: _searchQuery,
                    // sortBy: _sortBy,
                    // isAsc: _isAsc,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
            TextButton(
              onPressed: () {
                context.read<WorkOrderBloc>().add(
                  LoadWorkOrdersEvent(
                    // searchQuery: _searchQuery,
                    // status: _filterStatus,
                    // priority: _filterPriority,
                    // dateRange: _filterDateRange,
                    // assignedTechnician: _filterAssignedTechnician,
                    // sortBy: _sortBy,
                    // isAsc: _isAsc,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Terapkan'),
            ),
          ],
        );
      },
    );
  }
}

