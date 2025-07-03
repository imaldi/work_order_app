// lib/presentation/pages/home_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_order_app/core/consts_and_enums/enums/sort_by_enum.dart';
import 'package:work_order_app/core/router/router.dart';
import 'package:work_order_app/core/utils/extensions/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../../core/injection/injection.dart';
import '../../../technician/presentation/bloc/technician_bloc.dart';
import '../../../work_order/presentation/bloc/work_order_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<WorkOrderBloc>()..add(LoadWorkOrdersEvent())),
        // BlocProvider.value(value: getIt<TechnicianBloc>()..add(LoadTechniciansEvent())),
      ],
      child: this,
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.settings),
            onSelected: (value) {
              // Tangani pilihan menu
              if (value == 'manage_technician') {
                context.router.push(TechnicianListRoute());
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'manage_technician',
                  child: Text('Manage Technician'),
                ),
              ];
          },
          ),
        ]
      ),
      body: BlocConsumer<WorkOrderBloc, WorkOrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var list = state.whenOrNull(loaded: (orders) => orders) ?? [];
          var assignedCount = list.where((el) => el.status == WorkOrderStatus.pending.value).length;
          var inProgressCount = list.where((el) => el.status == WorkOrderStatus.inProgress.value).length;
          var completedCount = list.where((el) => el.status == WorkOrderStatus.completed.value).length;

          var todayDate = DateTime.now();
          var todayList = list.where((el) {
            var formattedDueDate = DateFormat('yy-MM-dd HH:mm').parse(el.dueDate);
            return formattedDueDate.year == todayDate.year &&
                formattedDueDate.month == todayDate.month &&
                formattedDueDate.day == todayDate.day;
          }).toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetricCard('Assigned', assignedCount, Colors.blue),
                    _buildMetricCard('In Progress', inProgressCount, Colors.orange),
                    _buildMetricCard('Completed', completedCount, Colors.green),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Today\'s Schedule',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: todayList.length,
                    itemBuilder: (ctx, idx){
                      var item = todayList[idx];
                      return _buildScheduleItem(
                        item.title ?? 'AC Repair',
                        item.address ?? 'Downtown Office',
                        '9:00 AM - 11:00 AM',
                        Icons.build,
                      );
                    },
                    // children: [
                    //   _buildScheduleItem(
                    //     'Emergency Plumbing',
                    //     'Downtown Office',
                    //     '1:30 PM - 3:00 PM',
                    //     Icons.warning,
                    //   ),
                    //   _buildScheduleItem(
                    //     'Light Installation',
                    //     'West Wing',
                    //     '3:30 PM - 4:30 PM',
                    //     Icons.lightbulb,
                    //   ),
                    // ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        _buildActionButton('Work Orders', Icons.cases_sharp, onTap: (){
                          context.router.push(WorkOrderListRoute());
                        }),
                        _buildActionButton('Groups', Icons.group, onTap: (){
                          context.router.push(WorkOrderGroupListRoute());
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        _buildActionButton('Inventory', Icons.inventory),
                        _buildActionButton('Messages', Icons.email),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard(String title, int count, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(count.toString(), style: const TextStyle(fontSize: 24, color: Colors.white)),
              Text(title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String title, String location, String time, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text('$location\n$time'),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: Colors.lightBlue[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [Icon(icon, size: 30), const SizedBox(height: 8.0), Text(title)]),
          ),
        ),
      ),
    );
  }
}
