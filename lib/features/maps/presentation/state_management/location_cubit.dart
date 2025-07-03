import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network_info/network_info.dart';
import '../../repository/location_repository.dart';

part 'location_cubit.freezed.dart';

part 'location_cubit.g.dart';

part 'location_state.dart';

@lazySingleton
class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this._repository, this._networkInfo)
      : super(const LocationState.initial(LocationParam()));

  final NetworkInfo _networkInfo;
  final LocationRepository _repository;

  Future<void> updateSelectedCoordinate(double latitude, double longitude, {String? altName}) async {
    await _getAddress(
      latitude, longitude, altName: altName);
    emit(LocationState.successSelectLocation(state.param
        .copyWith(latitude: latitude, longitude: longitude)
    ));
    // emit(LocationState.success(state.param));
  }

  getCurrentLocationCoordinateAndAddress() async {
    await _getCurrentCoordinate();
    await _getAddress(
        state.param.latitude ?? 0.0, state.param.longitude ?? 0.0);
  }

  _getCurrentCoordinate() async {
    emit(LocationState.loading(state.param));
    var result = await _repository.getCurrentPosition();
    result.fold(
        (l) => emit(LocationState.failure(state.param)),
        (r) => emit(LocationState.success(state.param
            .copyWith(latitude: r.latitude, longitude: r.longitude))));

    print("LATITUDE FROM CUBIT: ${state.param.latitude}");
    print("LONGITUDE FROM CUBIT: ${state.param.longitude}");
  }

  _getAddress(double lat, double long, {String? altName}) async {
    emit(LocationState.loading(state.param));

    var result = await _repository.getCurrentAddress(lat, long, altName: altName);
    result.fold(
        (l) => emit(LocationState.failure(state.param)),
        (r) => emit(LocationState.success(
          // tambah disini kota kabupaten
            state.param.copyWith(
                currentAddress: r?.displayName,
                simpleName: r?.displayName,
                latitude: lat,
                longitude: long,
                kotaKabupaten: r?.address?.cityDistrict))));
  }
}
