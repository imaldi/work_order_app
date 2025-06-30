// lib/router.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:work_order_app/features/home/presentation/screens/home_screen.dart';
import 'package:work_order_app/work_order/presentation/screens/add_work_order_screen.dart';
import 'package:work_order_app/work_order/presentation/screens/edit_work_order_screen.dart';
import 'package:work_order_app/technician/presentation/screens/technician_list_screen.dart';
import 'package:work_order_app/technician/presentation/screens/add_technician_screen.dart';
import 'package:work_order_app/technician/presentation/screens/edit_technician_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    // AutoRoute(screen: AddWorkOrderRoute.screen),
    // AutoRoute(screen: EditWorkOrderRoute.screen),
    // AutoRoute(screen: TechnicianListRoute.screen),
    // AutoRoute(screen: AddTechnicianRoute.screen),
    // AutoRoute(screen: EditTechnicianRoute.screen),
  ];
}