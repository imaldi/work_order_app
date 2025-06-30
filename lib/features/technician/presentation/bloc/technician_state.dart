part of 'technician_bloc.dart';

@freezed
class TechnicianState with _$TechnicianState {
  const factory TechnicianState.initial() = _technicianInitial;
  const factory TechnicianState.loading() = _technicianLoading;
  const factory TechnicianState.loaded(List<TechnicianEntity> technicians) = _technicianLoaded;
  const factory TechnicianState.error(Failure failure) = _technicianError;
}
