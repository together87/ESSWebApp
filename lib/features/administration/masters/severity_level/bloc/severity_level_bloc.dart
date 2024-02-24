import 'dart:async';
import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/bloc/severity_level_event.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/bloc/severity_level_state.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/repository/severity_level_repository.dart';

class SeveritylevelBloc extends Bloc<SeveritylevelEvents, SeveritylevelState> {
  final SeverityLevelRepository severityLevelRepository;

  SeveritylevelBloc({required this.severityLevelRepository})
      : super(const SeveritylevelState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<GetLoadSeverityByIdEvent>(_onGetLoadSeverityByIdEvent);
    on<SeveritylevelCreateNewEvent>(_onSeveritylevelCreateNewEvent);
    on<SeveritylevelPageChangeEvent>(_onSeveritylevelPageChangeEvent);
    on<SeveritylevelUpdateEvent>(_onSeveritylevelUpdateEvent);
    on<SeveritylevelDeleteEvent>(_onSeveritylevelDeleteEvent);
    on<SeveritylevelLoadingEvent>(_onSeveritylevelLoadingEvent);
    on<selectedSeverityLevelEvent>(_onselectedSeverityLevelEvent);
  }

  FutureOr<void> _onSeveritylevelLoadingEvent(
      SeveritylevelLoadingEvent event, Emitter<SeveritylevelState> emit) async {
    emit(state.copyWith(severitylevelCrud: EntityStatus.loading));

    try {
      List<SeverityLevel> severitylevelList =
          await severityLevelRepository.getAllSeverityLevels();
      if (severitylevelList.isNotEmpty) {
        emit(state.copyWith(
          severityPage: 0,
          severityLevelList: severitylevelList,
          selectedSeverityLevel: severitylevelList.first,
          severitylevelCrud: EntityStatus.success,
        ));
      } else {
        emit(state.copyWith(
          severityPage: 0,
          severityLevelList: const [],
          selectedSeverityLevel: null,
          severitylevelCrud: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        severityPage: 0,
        severitylevelCrud: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all severityLevel: $e");
    }
  }

  FutureOr<void> _onGetLoadSeverityByIdEvent(
      GetLoadSeverityByIdEvent event, Emitter<SeveritylevelState> emit) {}

  FutureOr<void> _onSeveritylevelCreateNewEvent(
      SeveritylevelCreateNewEvent event,
      Emitter<SeveritylevelState> emit) async {
    emit(state.copyWith(
      severitylevelCrud: EntityStatus.loading,
      severityPage: 0,
    ));
    try {
      EntityResponse response = await severityLevelRepository
          .createSeverityLevel(event.severitylevel);
      if (response.isSuccess) {
        List<SeverityLevel> severitylevelList =
            await severityLevelRepository.getAllSeverityLevels();
        emit(state.copyWith(
          severityLevelList: severitylevelList,
          selectedSeverityLevel: severitylevelList.first,
          severitylevelCrud: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          severityLevelList: null,
          selectedSeverityLevel: null,
          message: response.message,
          severitylevelCrud: EntityStatus.failure,
          severityPage: 1,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        severityLevelList: const [],
        selectedSeverityLevel: null,
        message: e.toString(),
        severitylevelCrud: EntityStatus.failure,
        severityPage: 1,
      ));
    }
  }

  FutureOr<void> _onSeveritylevelPageChangeEvent(
      SeveritylevelPageChangeEvent event, Emitter<SeveritylevelState> emit) {
    emit(state.copyWith(
      severitylevelCrud: EntityStatus.loading,
      severityPage: 0,
    ));
    try {
      emit(state.copyWith(
        severityPage: event.page,
        severitylevelCrud: EntityStatus.success,
        selectedSeverityLevel: event.severitylevel,
      ));
    } catch (e) {
      emit(state.copyWith(
        severityPage: 0,
        message: e.toString(),
        selectedSeverityLevel: null,
        severitylevelCrud: EntityStatus.failure,
      ));
    }
  }

  FutureOr<void> _onSeveritylevelUpdateEvent(
      SeveritylevelUpdateEvent event, Emitter<SeveritylevelState> emit) async {
    emit(state.copyWith(
      severitylevelCrud: EntityStatus.loading,
      severityPage: 0,
    ));
    try {
      EntityResponse response = await severityLevelRepository
          .updateSeverityLevel(event.severitylevel);
      if (response.isSuccess) {
        List<SeverityLevel> severitylevelList =
            await severityLevelRepository.getAllSeverityLevels();
        emit(state.copyWith(
          severityLevelList: severitylevelList,
          selectedSeverityLevel: event.severitylevel,
          severitylevelCrud: EntityStatus.success,
          message: response.message,
          severityPage: 0,
        ));
      } else {
        emit(state.copyWith(
          severityLevelList: null,
          selectedSeverityLevel: null,
          message: response.message,
          severitylevelCrud: EntityStatus.failure,
          severityPage: 2,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        severityLevelList: const [],
        selectedSeverityLevel: null,
        message: e.toString(),
        severitylevelCrud: EntityStatus.failure,
        severityPage: 2,
      ));
    }
  }

  FutureOr<void> _onSeveritylevelDeleteEvent(
      SeveritylevelDeleteEvent event, Emitter<SeveritylevelState> emit) async {
    emit(state.copyWith(
      severitylevelCrud: EntityStatus.loading,
      severityPage: 0,
    ));
    try {
      EntityResponse response =
          await severityLevelRepository.deleteSeverityLevel(event.id);
      if (response.isSuccess) {
        emit(state.copyWith(
          severitylevelCrud: EntityStatus.success,
          message: response.message,
          severityPage: 0,
        ));
        add(SeveritylevelLoadingEvent());
      } else {
        emit(state.copyWith(
          severityLevelList: null,
          selectedSeverityLevel: null,
          message: response.message,
          severitylevelCrud: EntityStatus.failure,
          severityPage: 3,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        severityLevelList: const [],
        selectedSeverityLevel: null,
        message: e.toString(),
        severitylevelCrud: EntityStatus.failure,
        severityPage: 3,
      ));
      debugPrint("Error while deleting severity level : $e");
    }
  }

  FutureOr<void> _onselectedSeverityLevelEvent(selectedSeverityLevelEvent event,
      Emitter<SeveritylevelState> emit) async {
    try {
      emit(state.copyWith(
        selectedSeverityLevel: event.severitylevel,
        severitylevelCrud: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedSeverityLevel: null,
        severitylevelCrud: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
