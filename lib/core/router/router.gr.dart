// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddTechnicianScreen]
class AddTechnicianRoute extends PageRouteInfo<void> {
  const AddTechnicianRoute({List<PageRouteInfo>? children})
    : super(AddTechnicianRoute.name, initialChildren: children);

  static const String name = 'AddTechnicianRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AddTechnicianScreen());
    },
  );
}

/// generated route for
/// [AddWorkOrderScreen]
class AddWorkOrderRoute extends PageRouteInfo<void> {
  const AddWorkOrderRoute({List<PageRouteInfo>? children})
    : super(AddWorkOrderRoute.name, initialChildren: children);

  static const String name = 'AddWorkOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AddWorkOrderScreen());
    },
  );
}

/// generated route for
/// [EditTechnicianScreen]
class EditTechnicianRoute extends PageRouteInfo<EditTechnicianRouteArgs> {
  EditTechnicianRoute({
    Key? key,
    required TechnicianEntity technician,
    List<PageRouteInfo>? children,
  }) : super(
         EditTechnicianRoute.name,
         args: EditTechnicianRouteArgs(key: key, technician: technician),
         initialChildren: children,
       );

  static const String name = 'EditTechnicianRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTechnicianRouteArgs>();
      return WrappedRoute(
        child: EditTechnicianScreen(key: args.key, technician: args.technician),
      );
    },
  );
}

class EditTechnicianRouteArgs {
  const EditTechnicianRouteArgs({this.key, required this.technician});

  final Key? key;

  final TechnicianEntity technician;

  @override
  String toString() {
    return 'EditTechnicianRouteArgs{key: $key, technician: $technician}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditTechnicianRouteArgs) return false;
    return key == other.key && technician == other.technician;
  }

  @override
  int get hashCode => key.hashCode ^ technician.hashCode;
}

/// generated route for
/// [EditWorkOrderScreen]
class EditWorkOrderRoute extends PageRouteInfo<EditWorkOrderRouteArgs> {
  EditWorkOrderRoute({
    Key? key,
    required WorkOrderEntity workOrder,
    List<PageRouteInfo>? children,
  }) : super(
         EditWorkOrderRoute.name,
         args: EditWorkOrderRouteArgs(key: key, workOrder: workOrder),
         initialChildren: children,
       );

  static const String name = 'EditWorkOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditWorkOrderRouteArgs>();
      return WrappedRoute(
        child: EditWorkOrderScreen(key: args.key, workOrder: args.workOrder),
      );
    },
  );
}

class EditWorkOrderRouteArgs {
  const EditWorkOrderRouteArgs({this.key, required this.workOrder});

  final Key? key;

  final WorkOrderEntity workOrder;

  @override
  String toString() {
    return 'EditWorkOrderRouteArgs{key: $key, workOrder: $workOrder}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditWorkOrderRouteArgs) return false;
    return key == other.key && workOrder == other.workOrder;
  }

  @override
  int get hashCode => key.hashCode ^ workOrder.hashCode;
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [MenuScreen]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
    : super(MenuRoute.name, initialChildren: children);

  static const String name = 'MenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MenuScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [TechnicianListScreen]
class TechnicianListRoute extends PageRouteInfo<void> {
  const TechnicianListRoute({List<PageRouteInfo>? children})
    : super(TechnicianListRoute.name, initialChildren: children);

  static const String name = 'TechnicianListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const TechnicianListScreen());
    },
  );
}

/// generated route for
/// [WorkOrderListScreen]
class WorkOrderListRoute extends PageRouteInfo<void> {
  const WorkOrderListRoute({List<PageRouteInfo>? children})
    : super(WorkOrderListRoute.name, initialChildren: children);

  static const String name = 'WorkOrderListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const WorkOrderListScreen());
    },
  );
}
