part of 'technician_bloc.dart';

@freezed
class TechnicianEvent with _$TechnicianEvent {
  const factory TechnicianEvent.loadTechnicians() = LoadTechniciansEvent;
  const factory TechnicianEvent.addTechnician(AddTechnicianParams params) = AddTechnicianEvent;
  const factory TechnicianEvent.updateTechnician(UpdateTechnicianParams params) = UpdateTechnicianEvent;
  const factory TechnicianEvent.deleteTechnician(DeleteTechnicianParams params) = DeleteTechnicianEvent;
}
