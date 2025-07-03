import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:work_order_app/features/home/presentation/screens/home_screen.dart';
import 'package:work_order_app/features/technician/presentation/screens/technician_list_screen.dart';
import 'package:work_order_app/features/technician/presentation/screens/add_technician_screen.dart';
import 'package:work_order_app/features/technician/presentation/screens/edit_technician_screen.dart';
import 'package:work_order_app/features/work_order/presentation/screens/work_order_list_screen.dart';
import 'package:work_order_app/features/work_order/presentation/screens/add_work_order_screen.dart';
import 'package:work_order_app/features/work_order/presentation/screens/edit_work_order_screen.dart';

import '../../features/home/presentation/screens/main_screen.dart';
import '../../features/home/presentation/screens/menu_screen.dart';
import '../../features/home/presentation/screens/splash_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/technician/domain/entity/technician_entity.dart';
import '../../features/work_order/domain/entities/work_order_entity.dart';
import '../../features/work_order/presentation/screens/work_order_detail_screen.dart';
import '../../features/work_order_group/domain/entity/work_order_group_entity.dart';
import '../../features/work_order_group/presentation/screens/create_work_order_group_screen.dart';
import '../../features/work_order_group/presentation/screens/edit_work_order_group_screen.dart';
import '../../features/work_order_group/presentation/screens/work_order_group_list_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: MenuRoute.page),

    AutoRoute(path: '/dashboard', page: MainRoute.page, children: [
      AutoRoute(page: HomeRoute.page),
      AutoRoute(page: WorkOrderListRoute.page),
      AutoRoute(page: WorkOrderGroupListRoute.page),
      AutoRoute(page: ProfileRoute.page),
    ]),
    AutoRoute(page: TechnicianListRoute.page),
    AutoRoute(page: CreateWorkOrderGroupRoute.page),
    AutoRoute(page: EditWorkOrderGroupRoute.page),
    AutoRoute(page: AddWorkOrderRoute.page),
    AutoRoute(page: EditWorkOrderRoute.page),
    AutoRoute(page: WorkOrderDetailRoute.page),
    AutoRoute(page: AddTechnicianRoute.page),
    AutoRoute(page: EditTechnicianRoute.page),
  ];
}