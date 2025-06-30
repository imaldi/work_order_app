import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/params/params.dart';
import '../../../../core/params/technician_params.dart';
import '../../domain/entity/technician_entity.dart';
import '../../domain/use_cases/add_technician.dart';
import '../../domain/use_cases/delete_technician.dart';
import '../../domain/use_cases/get_all_technicians.dart';
import '../../domain/use_cases/update_technician.dart';

part 'technician_event.dart';
part 'technician_state.dart';
part 'technician_bloc.freezed.dart';

@injectable
class TechnicianBloc extends Bloc<TechnicianEvent, TechnicianState> {
  final AddTechnician addTechnician;
  final GetAllTechnicians getAllTechnicians;
  final UpdateTechnician updateTechnician;
  final DeleteTechnician deleteTechnician;
  TechnicianBloc(
      this.getAllTechnicians,
      this.addTechnician,
      this.updateTechnician,
      this.deleteTechnician
      ) : super(const TechnicianState.initial()) {
    on<TechnicianEvent>((event, emit) {
      on<LoadTechniciansEvent>(_onLoadTechnicians);
      on<AddTechnicianEvent>(_onAddTechnician);
      on<UpdateTechnicianEvent>(_onUpdateTechnician);
      on<DeleteTechnicianEvent>(_onDeleteTechnician);
    });
  }

  FutureOr<void> _onLoadTechnicians(LoadTechniciansEvent event, Emitter<TechnicianState> emit) async {
    emit(const TechnicianState.loading());
    final result = await getAllTechnicians(
      NoParams(),
    ); // Kalau mau begini, di test nya harus sediakan stub nya
    result.fold(
          (error) => emit(TechnicianState.error(error)),
          (technicians) => emit(TechnicianState.loaded(technicians)),
    );
  }
  
  FutureOr<void> _onAddTechnician(AddTechnicianEvent event, Emitter<TechnicianState> emit) async {
    emit(const TechnicianState.loading());
    final result = await addTechnician(event.params);
    result.fold(
          (error) => emit(TechnicianState.error(error)),
          (_) => add(const LoadTechniciansEvent()),
    );
  }

  FutureOr<void> _onUpdateTechnician(UpdateTechnicianEvent event, Emitter<TechnicianState> emit) async {
    emit(const TechnicianState.loading());
    final result = await updateTechnician(event.params);
    result.fold(
          (error) => emit(TechnicianState.error(error)),
          (_) => add(const LoadTechniciansEvent()),
    );
  }

  FutureOr<void> _onDeleteTechnician(DeleteTechnicianEvent event, Emitter<TechnicianState> emit) async {
    emit(const TechnicianState.loading());
    final result = await deleteTechnician(event.params);
    result.fold(
          (error) => emit(TechnicianState.error(error)),
          (_) => add(const LoadTechniciansEvent()),
    );
  }
}
