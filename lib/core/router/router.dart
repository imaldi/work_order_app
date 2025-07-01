import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:work_order_app/features/home/presentation/screens/home_screen.dart';
import 'package:work_order_app/features/technician/presentation/screens/technician_list_screen.dart';
import 'package:work_order_app/features/technician/presentation/screens/add_technician_screen.dart';
import 'package:work_order_app/features/technician/presentation/screens/edit_technician_screen.dart';
import 'package:work_order_app/features/work_order/presentation/screens/work_order_list_screen.dart';
import 'package:work_order_app/features/work_order/presentation/screens/add_work_order_screen.dart';
import 'package:work_order_app/features/work_order/presentation/screens/edit_work_order_screen.dart';

import '../../features/technician/domain/entity/technician_entity.dart';
import '../../features/work_order/domain/entities/work_order_entity.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: WorkOrderListRoute.page),
    AutoRoute(page: AddWorkOrderRoute.page),
    AutoRoute(page: EditWorkOrderRoute.page),
    AutoRoute(page: TechnicianListRoute.page, initial: true),
    AutoRoute(page: AddTechnicianRoute.page),
    AutoRoute(page: EditTechnicianRoute.page),
  ];
}