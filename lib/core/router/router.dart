// lib/router.dart
import 'package:auto_route/auto_route.dart';
import 'package:work_order_app/features/home/presentation/screens/home_screen.dart';

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