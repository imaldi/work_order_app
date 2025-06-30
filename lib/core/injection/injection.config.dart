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
import 'package:work_order_app/core/helpers/database_helper.dart' as _i21;
import 'package:work_order_app/features/technician/data/data_sources/technician_local_data_source.dart'
    as _i349;
import 'package:work_order_app/features/technician/data/repository/technician_repository_impl.dart'
    as _i965;
import 'package:work_order_app/features/technician/domain/repository/technician_repository.dart'
    as _i1026;
import 'package:work_order_app/features/technician/domain/use_cases/add_technician.dart'
    as _i504;
import 'package:work_order_app/features/technician/domain/use_cases/delete_technician.dart'
    as _i688;
import 'package:work_order_app/features/technician/domain/use_cases/get_all_technicians.dart'
    as _i486;
import 'package:work_order_app/features/technician/domain/use_cases/update_technician.dart'
    as _i139;
import 'package:work_order_app/features/technician/presentation/bloc/technician_bloc.dart'
    as _i697;
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart'
    as _i688;
import 'package:work_order_app/features/work_order/data/repository/work_order_repository_impl.dart'
    as _i81;
import 'package:work_order_app/features/work_order/domain/repository/work_order_repository.dart'
    as _i476;
import 'package:work_order_app/features/work_order/domain/use_cases/add_work_order.dart'
    as _i658;
import 'package:work_order_app/features/work_order/domain/use_cases/delete_work_order.dart'
    as _i1034;
import 'package:work_order_app/features/work_order/domain/use_cases/filter_work_orders.dart'
    as _i752;
import 'package:work_order_app/features/work_order/domain/use_cases/get_all_work_orders.dart'
    as _i623;
import 'package:work_order_app/features/work_order/domain/use_cases/search_work_orders.dart'
    as _i300;
import 'package:work_order_app/features/work_order/domain/use_cases/sort_work_orders.dart'
    as _i853;
import 'package:work_order_app/features/work_order/domain/use_cases/update_work_order.dart'
    as _i167;
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart'
    as _i535;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i21.DatabaseHelper>(
      () => _i21.DatabaseHelper(testDbPath: gh<String>()),
    );
    gh.lazySingleton<_i688.WorkOrderLocalDataSource>(
      () => _i688.WorkOrderLocalDataSourceImpl(gh<_i21.DatabaseHelper>()),
    );
    gh.lazySingleton<_i349.TechnicianLocalDataSource>(
      () => _i349.TechnicianLocalDataSourceImpl(gh<_i21.DatabaseHelper>()),
    );
    gh.lazySingleton<_i476.WorkOrderRepository>(
      () => _i81.WorkOrderRepositoryImpl(gh<_i688.WorkOrderLocalDataSource>()),
    );
    gh.lazySingleton<_i1026.TechnicianRepository>(
      () =>
          _i965.TechnicianRepositoryImpl(gh<_i349.TechnicianLocalDataSource>()),
    );
    gh.lazySingleton<_i139.UpdateTechnician>(
      () => _i139.UpdateTechnician(gh<_i1026.TechnicianRepository>()),
    );
    gh.lazySingleton<_i504.AddTechnician>(
      () => _i504.AddTechnician(gh<_i1026.TechnicianRepository>()),
    );
    gh.lazySingleton<_i486.GetAllTechnicians>(
      () => _i486.GetAllTechnicians(gh<_i1026.TechnicianRepository>()),
    );
    gh.lazySingleton<_i688.DeleteTechnician>(
      () => _i688.DeleteTechnician(gh<_i1026.TechnicianRepository>()),
    );
    gh.lazySingleton<_i752.FilterWorkOrders>(
      () => _i752.FilterWorkOrders(gh<_i476.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i1034.DeleteWorkOrder>(
      () => _i1034.DeleteWorkOrder(gh<_i476.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i300.SearchWorkOrders>(
      () => _i300.SearchWorkOrders(gh<_i476.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i853.SortWorkOrders>(
      () => _i853.SortWorkOrders(gh<_i476.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i623.GetAllWorkOrders>(
      () => _i623.GetAllWorkOrders(gh<_i476.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i658.AddWorkOrder>(
      () => _i658.AddWorkOrder(gh<_i476.WorkOrderRepository>()),
    );
    gh.lazySingleton<_i167.UpdateWorkOrder>(
      () => _i167.UpdateWorkOrder(gh<_i476.WorkOrderRepository>()),
    );
    gh.factory<_i535.WorkOrderBloc>(
      () => _i535.WorkOrderBloc(
        gh<_i658.AddWorkOrder>(),
        gh<_i623.GetAllWorkOrders>(),
        gh<_i167.UpdateWorkOrder>(),
        gh<_i1034.DeleteWorkOrder>(),
        gh<_i300.SearchWorkOrders>(),
        gh<_i853.SortWorkOrders>(),
        gh<_i752.FilterWorkOrders>(),
      ),
    );
    gh.factory<_i697.TechnicianBloc>(
      () => _i697.TechnicianBloc(
        gh<_i486.GetAllTechnicians>(),
        gh<_i504.AddTechnician>(),
        gh<_i139.UpdateTechnician>(),
        gh<_i688.DeleteTechnician>(),
      ),
    );
    return this;
  }
}
