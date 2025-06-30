part of 'technician_bloc.dart';

@freezed
class TechnicianState with _$TechnicianState {
  const factory TechnicianState.initial() = TechnicianInitial;
  const factory TechnicianState.loading() = TechnicianLoading;
  const factory TechnicianState.loaded(List<TechnicianEntity> technicians) = TechnicianLoaded;
  const factory TechnicianState.error(Failure failure) = TechnicianError;
}
