// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/technician/data/data_sources/technician_local_data_source.dart'
    as _i929;
import '../../features/technician/data/repository/technician_repository_impl.dart'
    as _i334;
import '../../features/technician/domain/repository/technician_repository.dart'
    as _i702;
import '../../features/technician/domain/use_cases/add_technician.dart'
    as _i401;
import '../../features/technician/domain/use_cases/delete_technician.dart'
    as _i423;
import '../../features/technician/domain/use_cases/get_all_technicians.dart'
    as _i981;
import '../../features/technician/domain/use_cases/update_technician.dart'
    as _i374;
import '../../features/technician/presentation/bloc/technician_bloc.dart'
    as _i1031;
import '../../features/work_order/data/data_sources/work_order_local_data_source.dart'
    as _i416;
import '../../features/work_order/data/repository/work_order_repository_impl.dart'
    as _i258;
import '../../features/work_order/domain/repository/work_order_repository.dart'
    as _i750;
import '../../features/work_order/domain/use_cases/add_work_order.dart'
    as _i1053;
import '../../features/work_order/domain/use_cases/delete_work_order.dart'
    as _i615;
import '../../features/work_order/domain/use_cases/filter_work_orders.dart'
    as _i962;
import '../../features/work_order/domain/use_cases/get_all_work_orders.dart'
    as _i676;
import '../../features/work_order/domain/use_cases/search_work_orders.dart'
    as _i423;
import '../../features/work_order/domain/use_cases/sort_work_orders.dart'
    as _i384;
import '../../features/work_order/domain/use_cases/update_work_order.dart'
    as _i654;
import '../../features/work_order/presentation/bloc/work_order_bloc.dart'
    as _i683;
import '../../features/work_order_group/data/data_sources/work_order_group_local_data_source.dart'
    as _i515;
import '../../features/work_order_group/domain/repository/work_order_group_repository.dart'
    as _i959;
import '../../features/work_order_group/domain/usecases/create_work_order_group.dart'
    as _i500;
import '../../features/work_order_group/domain/usecases/delete_work_order_group.dart'
    as _i129;
import '../../features/work_order_group/domain/usecases/get_all_work_order_groups.dart'
    as _i39;
import '../../features/work_order_group/domain/usecases/update_work_order_group.dart'
    as _i702;
import '../../features/work_order_group/presentation/bloc/work_order_group_bloc.dart'
    as _i274;
import '../helpers/database_helper.dart' as _i771;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i771.DatabaseHelper>(() => _i771.DatabaseHelper());
    gh.lazySingleton<_i500.CreateWorkOrderGroup>(
      () => _i500.CreateWorkOrderGroup(gh<_i959.WorkOrderGroupRepository>()),
    );
    gh.lazySingleton<_i39.GetAllWorkOrderGroups>(
      () => _i39.GetAllWorkOrderGroups(gh<_i959.WorkOrderGroupRepository>()),
    );
    gh.lazySingleton<_i702.UpdateWorkOrderGroup>(
      () => _i702.UpdateWorkOrderGroup(gh<_i959.WorkOrderGroupRepository>()),
    );
    gh.lazySingleton<_i129.DeleteWorkOrderGroup>(
      () => _i129.DeleteWorkOrderGroup(gh<_i959.WorkOrderGroupRepository>()),
    );
    gh.lazySingleton<_i274.WorkOrderGroupBloc>(
      () => _i274.WorkOrderGroupBloc(
        gh<_i39.GetAllWorkOrderGroups>(),
        gh<_i500.CreateWorkOrderGroup>(),
        gh<_i702.UpdateWorkOrderGroup>(),
        gh<_i129.DeleteWorkOrderGroup>(),
      ),
    );
    gh.lazySingleton<_i929.TechnicianLocalDataSource>(
      () => _i929.TechnicianLocalDataSourceImpl(gh<_i771.DatabaseHelper>()),
    );
    gh.lazySingleton<_i515.WorkOrderGroupLocalDataSource>(
      () => _i515.WorkOrderGroupLocalDataSourceImpl(gh<_i771.DatabaseHelper>()),
    );
    gh.lazySingleton<_i416.WorkOrderLocalDataSource>(
      () => _i416.WorkOrderLocalDataSourceImpl(gh<_i771.DatabaseHelper>()),
    );
    gh.lazySingleton<_i702.TechnicianRepository>(
      () =>
          _i334.TechnicianRepositoryImpl(gh<_i929.TechnicianLocalDataSource>()),
    );
    gh.lazySingleton<_i374.UpdateTechnician>(
      () => _i374.UpdateTechnician(gh<_i702.TechnicianRepository>()),
    );
    gh.lazySingleton<_i401.AddTechnician>(
      () => _i401.AddTechnician(gh<_i702.TechnicianRepository>()),
    );
    gh.lazySingleton<_i981.GetAllTechnicians>(
      () => _i981.GetAllTechnicians(gh<_i702.TechnicianRepository>()),
    );
    gh.lazySingleton<_i423.DeleteTechnician>(
      () => _i423.DeleteTechnician(gh<_i702.TechnicianRepository>()),
    );
    gh.lazySingleton<_i1031.TechnicianBloc>(
      () => _i1031.TechnicianBloc(
        gh<_i981.GetAllTechnicians>(),
        gh<_i401.AddTechnician>(),
        gh<_i374.UpdateTechnician>(),
        gh<_i423.DeleteTechnician>(),
      ),
    );
    gh.lazySingleton<_i750.WorkOrderRepository>(
      () => _i258.WorkOrderRepositoryImpl(gh<_i416.WorkOrderLocalDataSource>()),
    );
    gh.lazySingleton<_i962.FilterWorkOrders>(
      () => _i962.FilterWorkOrders(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i615.DeleteWorkOrder>(
      () => _i615.DeleteWorkOrder(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i423.SearchWorkOrders>(
      () => _i423.SearchWorkOrders(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i384.SortWorkOrders>(
      () => _i384.SortWorkOrders(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i676.GetAllWorkOrders>(
      () => _i676.GetAllWorkOrders(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i1053.AddWorkOrder>(
      () => _i1053.AddWorkOrder(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i654.UpdateWorkOrder>(
      () => _i654.UpdateWorkOrder(gh<_i750.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i683.WorkOrderBloc>(
      () => _i683.WorkOrderBloc(
        gh<_i1053.AddWorkOrder>(),
        gh<_i676.GetAllWorkOrders>(),
        gh<_i654.UpdateWorkOrder>(),
        gh<_i615.DeleteWorkOrder>(),
        gh<_i423.SearchWorkOrders>(),
        gh<_i384.SortWorkOrders>(),
        gh<_i962.FilterWorkOrders>(),
      ),
    );
    return this;
  }
}
