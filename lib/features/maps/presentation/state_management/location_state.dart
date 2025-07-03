part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial(LocationParam param) = _Initial;
  const factory LocationState.loading(LocationParam param) = _Loading;
  const factory LocationState.failure(LocationParam param) = _Failure;
  const factory LocationState.success(LocationParam param) = _Success;
  const factory LocationState.successSelectLocation(LocationParam param) = _SuccessSelectLocation;
}

@freezed
class LocationParam with _$LocationParam {
  const factory LocationParam({
    @JsonKey(name: "current_address")
    String? currentAddress,
    @JsonKey(name: "simple_name")
    String? simpleName,
    @JsonKey(name: "kota_kabupaten")
    String? kotaKabupaten,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
  }) = _LocationParam;

  factory LocationParam.fromJson(Map<String, dynamic> json) => _$LocationParamFromJson(json);
}