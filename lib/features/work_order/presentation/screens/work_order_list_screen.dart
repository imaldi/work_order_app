import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/consts_and_enums/enums/sort_by_enum.dart';
import 'package:work_order_app/core/utils/extensions/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/params/params.dart';
import '../../../../core/router/router.dart';
import '../../../../widgets/my_confirm_dialog/my_confirm_dialog.dart';
import '../../../technician/presentation/bloc/technician_bloc.dart';
import '../../../work_order/presentation/bloc/work_order_bloc.dart';

@RoutePage()
class WorkOrderListScreen extends StatefulWidget implements AutoRouteWrapper {
  const WorkOrderListScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<WorkOrderBloc>()..add(LoadWorkOrdersEvent())),
        BlocProvider.value(value: getIt<TechnicianBloc>()..add(LoadTechniciansEvent())),
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
  WorkOrderSortFieldBy _sortBy = WorkOrderSortFieldBy.title; // title, priority, dueDate
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
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text('Daftar Work Order'),
        ),
        backgroundColor: Colors.blueAccent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                fillColor: Colors.white,
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
                  child: DropdownButton<WorkOrderSortFieldBy>(
                    value: _sortBy,
                    hint: const Text('Sort By'),
                    items: WorkOrderSortFieldBy.values
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.value.capitalize())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _sortBy = value!;
                      });
                      context.read<WorkOrderBloc>().add(
                        SortWorkOrdersEvent(
                          SortWorkOrdersParams(sortBy: _sortBy, isAscending: _isAsc),
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
                        SortWorkOrdersEvent(
                          SortWorkOrdersParams(sortBy: _sortBy, isAscending: _isAsc),
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
                        subtitle: Text('Status: ${WorkOrderStatus.values.firstWhere((el) => el.value == wo.status).string } | Priority: ${wo.priority}'),
                        onTap: () {
                          context.router.push(EditWorkOrderRoute(workOrder: wo));
                        },
                        trailing: ElevatedButton(
                          onPressed: () {
                            myConfirmDialog(
                              context,
                              title: "Yakin Hapus data Work Order?",
                              positiveButtonCallback: () {
                                context.read<WorkOrderBloc>().add(
                                  DeleteWorkOrderEvent(QueryIdParams(id: wo.id)),
                                );
                              },
                              positiveButtonText: "Ya",
                              negativeButtonCallback: () {
                                context.router.pop();
                              },
                              negativeButtonText: "Batal",
                            );
                          },
                          // style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.red),
                          child: const Text('Hapus'),
                        ),
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
          context.router.push(const AddWorkOrderRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    WorkOrderStatus? localFilterStatus = _filterStatus;
    WorkOrderPriority? localFilterPriority = _filterPriority;
    TechnicianEntity? localFilterAssignedTechnician = _filterAssignedTechnician;
    DateTimeRange? localFilterDateRange = _filterDateRange;
    showDialog(
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: getIt<WorkOrderBloc>()),
            BlocProvider.value(value: getIt<TechnicianBloc>()..add(LoadTechniciansEvent())),
          ],
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Filter Work Order'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<WorkOrderStatus?>(
                        value: localFilterStatus,
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
                            localFilterStatus = value;
                          });
                        },
                      ),
                      DropdownButton<WorkOrderPriority?>(
                        value: localFilterPriority,
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
                            localFilterPriority = value;
                          });
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          final dateRange = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            initialDateRange: localFilterDateRange,
                          );
                          setState(() {
                            _filterDateRange = dateRange;
                            localFilterDateRange = dateRange;
                          });
                        },
                        child: Text(
                          localFilterDateRange == null
                              ? 'Pilih Rentang Tanggal'
                              : 'Tanggal: ${localFilterDateRange!.start.toString().substring(0, 10)} - ${localFilterDateRange!.end.toString().substring(0, 10)}',
                        ),
                      ),
                      BlocBuilder<TechnicianBloc, TechnicianState>(
                        builder: (context, state) {
                          return state.whenOrNull(
                                loading: () => Center(child: CircularProgressIndicator()),
                                loaded: (technicianList) {
                                  return DropdownButton<TechnicianEntity>(
                                        value: localFilterAssignedTechnician,
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
                                            localFilterAssignedTechnician = value;
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
                  Builder(
                    builder: (context) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            localFilterStatus = null;
                            localFilterPriority = null;
                            localFilterAssignedTechnician = null;
                            localFilterDateRange = null;
                            // Update state induk
                            _filterDateRange = null;
                            _filterStatus = null;
                            _filterPriority = null;
                            _filterAssignedTechnician = null;
                          });
                        },
                        child: const Text('Reset'),
                      );
                    }
                  ),
                  Builder(
                    builder: (context) {
                      return TextButton(
                        onPressed: () {
                          context.read<WorkOrderBloc>().add(
                            FilterWorkOrdersEvent(
                              FilterWorkOrderParams(
                                status: _filterStatus?.value,
                                priority: _filterPriority?.value,
                                dateRange: _filterDateRange,
                                technicianId: _filterAssignedTechnician?.id,

                                // sortBy: _sortBy,
                                // isAsc: _isAsc,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Terapkan'),
                      );
                    }
                  ),
                ],
              );
            }
          ),
        );
      },
    );
  }
}
