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
/// [CreateWorkOrderGroupScreen]
class CreateWorkOrderGroupRoute extends PageRouteInfo<void> {
  const CreateWorkOrderGroupRoute({List<PageRouteInfo>? children})
    : super(CreateWorkOrderGroupRoute.name, initialChildren: children);

  static const String name = 'CreateWorkOrderGroupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreateWorkOrderGroupScreen());
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
/// [EditWorkOrderGroupScreen]
class EditWorkOrderGroupRoute
    extends PageRouteInfo<EditWorkOrderGroupRouteArgs> {
  EditWorkOrderGroupRoute({
    Key? key,
    required WorkOrderGroupEntity group,
    List<PageRouteInfo>? children,
  }) : super(
         EditWorkOrderGroupRoute.name,
         args: EditWorkOrderGroupRouteArgs(key: key, group: group),
         initialChildren: children,
       );

  static const String name = 'EditWorkOrderGroupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditWorkOrderGroupRouteArgs>();
      return WrappedRoute(
        child: EditWorkOrderGroupScreen(key: args.key, group: args.group),
      );
    },
  );
}

class EditWorkOrderGroupRouteArgs {
  const EditWorkOrderGroupRouteArgs({this.key, required this.group});

  final Key? key;

  final WorkOrderGroupEntity group;

  @override
  String toString() {
    return 'EditWorkOrderGroupRouteArgs{key: $key, group: $group}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditWorkOrderGroupRouteArgs) return false;
    return key == other.key && group == other.group;
  }

  @override
  int get hashCode => key.hashCode ^ group.hashCode;
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
      return WrappedRoute(child: const HomeScreen());
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
/// [MapRouteScreen]
class MapRouteRoute extends PageRouteInfo<MapRouteRouteArgs> {
  MapRouteRoute({
    required (double, double) addressCord,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         MapRouteRoute.name,
         args: MapRouteRouteArgs(addressCord: addressCord, key: key),
         initialChildren: children,
       );

  static const String name = 'MapRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MapRouteRouteArgs>();
      return WrappedRoute(
        child: MapRouteScreen(addressCord: args.addressCord, key: args.key),
      );
    },
  );
}

class MapRouteRouteArgs {
  const MapRouteRouteArgs({required this.addressCord, this.key});

  final (double, double) addressCord;

  final Key? key;

  @override
  String toString() {
    return 'MapRouteRouteArgs{addressCord: $addressCord, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapRouteRouteArgs) return false;
    return addressCord == other.addressCord && key == other.key;
  }

  @override
  int get hashCode => addressCord.hashCode ^ key.hashCode;
}

/// generated route for
/// [MapsScreen]
class MapsRoute extends PageRouteInfo<void> {
  const MapsRoute({List<PageRouteInfo>? children})
    : super(MapsRoute.name, initialChildren: children);

  static const String name = 'MapsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MapsScreen();
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
/// [WorkOrderDetailScreen]
class WorkOrderDetailRoute extends PageRouteInfo<WorkOrderDetailRouteArgs> {
  WorkOrderDetailRoute({
    required WorkOrderEntity workOrder,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         WorkOrderDetailRoute.name,
         args: WorkOrderDetailRouteArgs(workOrder: workOrder, key: key),
         initialChildren: children,
       );

  static const String name = 'WorkOrderDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkOrderDetailRouteArgs>();
      return WrappedRoute(
        child: WorkOrderDetailScreen(workOrder: args.workOrder, key: args.key),
      );
    },
  );
}

class WorkOrderDetailRouteArgs {
  const WorkOrderDetailRouteArgs({required this.workOrder, this.key});

  final WorkOrderEntity workOrder;

  final Key? key;

  @override
  String toString() {
    return 'WorkOrderDetailRouteArgs{workOrder: $workOrder, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WorkOrderDetailRouteArgs) return false;
    return workOrder == other.workOrder && key == other.key;
  }

  @override
  int get hashCode => workOrder.hashCode ^ key.hashCode;
}

/// generated route for
/// [WorkOrderGroupListScreen]
class WorkOrderGroupListRoute extends PageRouteInfo<void> {
  const WorkOrderGroupListRoute({List<PageRouteInfo>? children})
    : super(WorkOrderGroupListRoute.name, initialChildren: children);

  static const String name = 'WorkOrderGroupListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const WorkOrderGroupListScreen());
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
