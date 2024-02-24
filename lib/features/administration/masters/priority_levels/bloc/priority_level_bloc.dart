import 'dart:async';

import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_event.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_state.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/data/model/priority_level_response.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';

import '../../../../../common_libraries.dart';
import '../data/repository/priority_level_repository.dart';

class PriorityLevelBloc extends Bloc<PriorityLevelEvents, PriorityLevelState> {
  final PriorityLevelRepository repository;

  PriorityLevelBloc({required this.repository})
      : super(const PriorityLevelState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<LoadPriorityLevelByIdEvent>(_onLoadPriorityLevelByIdEvent);
    on<CreateNewPriorityLevelEvent>(_onCreateNewPriorityLevelEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdatePriorityLevelEvent>(_onUpdatePriorityLevelEvent);
    on<PriorityLevelSelectedEvent>(_onPriorityLevelSelectedEvent);
    on<DeletePriorityLevelEvent>(_onDeletePriorityLevelEvent);
    on<PriorityLevelLoadingEvent>(_onPriorityLevelLoadingEvent);
    on<getPriorityTypeByIdEvent>(_ongetPriorityTypeByIdEvent);
    on<CreatePriorityLevelEvent>(_onCreatePriorityLevelEvent);
    on<SelectPriorityTypeEvent>(_onSelectPriorityTypeEvent);
  }

  FutureOr<void> _onLoadPriorityLevelByIdEvent(
      LoadPriorityLevelByIdEvent event, Emitter<PriorityLevelState> emit) {}

  FutureOr<void> _onCreateNewPriorityLevelEvent(
      CreateNewPriorityLevelEvent event,
      Emitter<PriorityLevelState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response =
          await repository.createPriorityLevel(event.priorityLevel);
      if (response.isSuccess) {
        List<PriorityLevel> priorityLevelList =
            await repository.getAllPriorityLevels();
        emit(state.copyWith(
          priorityLevelList: priorityLevelList,
          selectedPriorityLevel: null,
          crudStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          priorityLevelList: null,
          selectedPriorityLevel: null,
          crudStatus: EntityStatus.failure,
          message: response.message,
          page: 1,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelList: null,
        selectedPriorityLevel: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
        page: 1,
      ));
    }
  }

  FutureOr<void> _onPageChangeEvent(
      PageChangeEvent event, Emitter<PriorityLevelState> emit) {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      PriorityType priorityType = PriorityType(
        id: event.priorityLevel!.priorityTypeId,
        name: event.priorityLevel!.priorityTypeName,
      );

      emit(state.copyWith(
        page: event.page,
        crudStatus: EntityStatus.success,
        message: null,
        selectedPriorityLevel: event.priorityLevel,
        selectedPriorityType: priorityType,
      ));
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        selectedPriorityLevel: null,
        crudStatus: EntityStatus.failure,
        message: null,
      ));
    }
  }

  FutureOr<void> _onUpdatePriorityLevelEvent(
      UpdatePriorityLevelEvent event, Emitter<PriorityLevelState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response =
          await repository.updatePriorityLevel(event.priorityLevel);
      if (response.isSuccess) {
        List<PriorityLevel> priorityLevelList =
            await repository.getAllPriorityLevels();
        emit(state.copyWith(
          priorityLevelList: priorityLevelList,
          selectedPriorityLevel: event.priorityLevel,
          selectedPriorityType: event.priorityType,
          crudStatus: EntityStatus.success,
          message: response.message,
          page: 0,
        ));
      } else {
        emit(state.copyWith(
          priorityLevelList: null,
          selectedPriorityType: event.priorityType,
          selectedPriorityLevel: event.priorityLevel,
          crudStatus: EntityStatus.failure,
          message: response.message,
          page: 2,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelList: const [],
        selectedPriorityType: event.priorityType,
        selectedPriorityLevel: event.priorityLevel,
        message: e.toString(),
        crudStatus: EntityStatus.failure,
        page: 2,
      ));
    }
  }

  FutureOr<void> _onPriorityLevelSelectedEvent(
      PriorityLevelSelectedEvent event, Emitter<PriorityLevelState> emit) {
    try {
      emit(state.copyWith(
        selectedPriorityLevel: event.priorityLevel,
        selectedPriorityType: state.selectedPriorityType,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedPriorityLevel: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onDeletePriorityLevelEvent(
      DeletePriorityLevelEvent event, Emitter<PriorityLevelState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response = await repository.deletePriorityLevel(event.id);
      if (response.isSuccess) {
        emit(state.copyWith(
          crudStatus: EntityStatus.success,
          message: response.message,
          page: 0,
        ));
        add(PriorityLevelLoadingEvent());
      } else {
        emit(state.copyWith(
          priorityLevelList: const [],
          selectedPriorityLevel: null,
          message: response.message,
          crudStatus: EntityStatus.failure,
          page: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityLevelList: const [],
        selectedPriorityLevel: null,
        message: e.toString(),
        crudStatus: EntityStatus.failure,
        page: 0,
      ));
      debugPrint("Error while deleting priority level : $e");
    }
  }

  FutureOr<void> _onPriorityLevelLoadingEvent(
      PriorityLevelLoadingEvent event, Emitter<PriorityLevelState> emit) async {
    emit(state.copyWith(crudStatus: EntityStatus.loading));

    try {
      List<PriorityLevel> priorityLevelList =
          await repository.getAllPriorityLevels();
      List<PriorityType> priorityTypeList =
          await repository.getAllPriorityTypes();
      if (priorityLevelList.isNotEmpty) {
        if (priorityTypeList.isNotEmpty) {
          emit(state.copyWith(
            page: 0,
            priorityLevelList: priorityLevelList,
            priorityTypeList: priorityTypeList,
            //selectedPriorityType: priorityTypeList.first,
            selectedPriorityLevel: priorityLevelList.first,
            crudStatus: EntityStatus.success,
          ));
        } else {
          emit(state.copyWith(
            page: 0,
            priorityLevelList: const [],
            priorityTypeList: const [],
            selectedPriorityType: null,
            selectedPriorityLevel: null,
            crudStatus: EntityStatus.success,
          ));
        }
      } else {
        emit(state.copyWith(
          page: 0,
          priorityLevelList: const [],
          selectedPriorityLevel: null,
          priorityTypeList: const [],
          selectedPriorityType: null,
          crudStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all priority level: $e");
    }
  }

  FutureOr<void> _ongetPriorityTypeByIdEvent(
      getPriorityTypeByIdEvent event, Emitter<PriorityLevelState> emit) async {
    try {
      PriorityType priorityType =
          await repository.getPriorityTypeById(event.id!);
      emit(state.copyWith(
        selectedPriorityType: priorityType,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedPriorityType: null,
      ));
      debugPrint("Error while  getting priority type: $e");
    }
  }

  FutureOr<void> _onCreatePriorityLevelEvent(
      CreatePriorityLevelEvent event, Emitter<PriorityLevelState> emit) async {
    emit(state.copyWith(crudStatus: EntityStatus.loading));

    try {
      List<PriorityType> priorityTypeList =
          await repository.getAllPriorityTypes();
      if (priorityTypeList.isNotEmpty) {
        emit(state.copyWith(
          page: event.page,
          priorityTypeList: priorityTypeList,
          //selectedPriorityType: priorityTypeList.first,
          crudStatus: EntityStatus.success,
        ));
      } else {
        emit(state.copyWith(
            page: 0,
            priorityTypeList: const [],
            selectedPriorityType: null,
            crudStatus: EntityStatus.failure,
            message: "Priority Type is not available."));
      }
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all PriorityType: $e");
    }
  }

  FutureOr<void> _onSelectPriorityTypeEvent(
      SelectPriorityTypeEvent event, Emitter<PriorityLevelState> emit) async {
    try {
      emit(state.copyWith(
        selectedPriorityType: event.priorityType,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedPriorityType: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
