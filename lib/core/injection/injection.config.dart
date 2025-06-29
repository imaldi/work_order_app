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
import 'package:work_order_app/features/work_order/data/data_sources/work_order_local_data_source.dart'
    as _i688;
import 'package:work_order_app/features/work_order/data/repositories/work_order_repository_impl.dart'
    as _i367;
import 'package:work_order_app/features/work_order/domain/repositories/work_order_repository.dart'
    as _i590;
import 'package:work_order_app/features/work_order/domain/use_cases/add_work_order.dart'
    as _i658;
import 'package:work_order_app/features/work_order/domain/use_cases/delete_work_order.dart'
    as _i1034;
import 'package:work_order_app/features/work_order/domain/use_cases/get_all_work_orders.dart'
    as _i623;
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
    gh.singleton<_i21.DatabaseHelper>(() => _i21.DatabaseHelper());
    gh.lazySingleton<_i688.WorkOrderLocalDataSource>(
      () => _i688.WorkOrderLocalDataSourceImpl(gh<_i21.DatabaseHelper>()),
    );
    gh.lazySingleton<_i590.WorkOrderRepository>(
      () => _i367.WorkOrderRepositoryImpl(gh<_i688.WorkOrderLocalDataSource>()),
    );
    gh.factory<_i658.AddWorkOrder>(
      () => _i658.AddWorkOrder(gh<_i590.WorkOrderRepository>()),
    );
    gh.factory<_i623.GetAllWorkOrders>(
      () => _i623.GetAllWorkOrders(gh<_i590.WorkOrderRepository>()),
    );
    gh.factory<_i1034.DeleteWorkOrder>(
      () => _i1034.DeleteWorkOrder(gh<_i590.WorkOrderRepository>()),
    );
    gh.factory<_i167.UpdateWorkOrder>(
      () => _i167.UpdateWorkOrder(gh<_i590.WorkOrderRepository>()),
    );
    gh.factory<_i535.WorkOrderBloc>(
      () => _i535.WorkOrderBloc(
        gh<_i658.AddWorkOrder>(),
        gh<_i623.GetAllWorkOrders>(),
        gh<_i167.UpdateWorkOrder>(),
        gh<_i1034.DeleteWorkOrder>(),
      ),
    );
    return this;
  }
}
