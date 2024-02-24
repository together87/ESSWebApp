import 'dart:async';
import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/repository/priority_type_repository.dart';

class PriorityTypeBloc extends Bloc<PriorityTypeEvents, PriorityTypeState> {
  final PriorityTypeRepository priorityTypeRepository;

  PriorityTypeBloc({required this.priorityTypeRepository})
      : super(const PriorityTypeState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<GetLoadPriorityTypeByIdEvent>(_onGetLoadPriorityTypeByIdEvent);
    on<PriorityTypeCreateNewEvent>(_onPriorityTypeCreateNewEvent);
    on<PriorityTypePageChangeEvent>(_onPriorityTypePageChangeEvent);
    on<PriorityTypeUpdateEvent>(_onPriorityTypeUpdateEvent);
    on<PriorityTypeDeleteEvent>(_onPriorityTypeDeleteEvent);
    on<PriorityTypeLoadingEvent>(_onPriorityTypeLoadingEvent);
    on<selectedPriorityTypeEvent>(_onselectedPriorityTypeEvent);
  }

  FutureOr<void> _onPriorityTypeLoadingEvent(
      PriorityTypeLoadingEvent event, Emitter<PriorityTypeState> emit) async {
    emit(state.copyWith(priorityTypeCrud: EntityStatus.loading));
    try {
      List<PriorityType> priorityTypeList =
          await priorityTypeRepository.getAllPriorityTypes();
      if (priorityTypeList.isNotEmpty) {
        emit(state.copyWith(
          priorityTypePage: 0,
          priorityTypeList: priorityTypeList,
          selectedPriorityType: priorityTypeList.first,
          priorityTypeCrud: EntityStatus.success,
        ));
      } else {
        emit(state.copyWith(
          priorityTypePage: 0,
          priorityTypeList: const [],
          selectedPriorityType: null,
          priorityTypeCrud: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityTypePage: 0,
        priorityTypeCrud: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all PriorityType: $e");
    }
  }

  FutureOr<void> _onGetLoadPriorityTypeByIdEvent(
      GetLoadPriorityTypeByIdEvent event, Emitter<PriorityTypeState> emit) {}

  FutureOr<void> _onPriorityTypeCreateNewEvent(
      PriorityTypeCreateNewEvent event, Emitter<PriorityTypeState> emit) async {
    emit(state.copyWith(
      priorityTypeCrud: EntityStatus.loading,
      priorityTypePage: 0,
    ));
    try {
      EntityResponse response =
          await priorityTypeRepository.createPriorityType(event.priorityType);
      if (response.isSuccess) {
        List<PriorityType> priorityTypeList =
            await priorityTypeRepository.getAllPriorityTypes();
        emit(state.copyWith(
          priorityTypeList: priorityTypeList,
          selectedPriorityType: priorityTypeList.first,
          priorityTypeCrud: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          priorityTypeList: null,
          selectedPriorityType: null,
          message: response.message,
          priorityTypeCrud: EntityStatus.failure,
          priorityTypePage: 1,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityTypeList: const [],
        selectedPriorityType: null,
        message: e.toString(),
        priorityTypeCrud: EntityStatus.failure,
        priorityTypePage: 1,
      ));
    }
  }

  FutureOr<void> _onPriorityTypePageChangeEvent(
      PriorityTypePageChangeEvent event, Emitter<PriorityTypeState> emit) {
    emit(state.copyWith(
      priorityTypeCrud: EntityStatus.loading,
      priorityTypePage: 0,
    ));
    try {
      emit(state.copyWith(
        priorityTypePage: event.page,
        priorityTypeCrud: EntityStatus.success,
        selectedPriorityType: event.priorityType,
      ));
    } catch (e) {
      emit(state.copyWith(
        priorityTypePage: 0,
        message: e.toString(),
        selectedPriorityType: null,
        priorityTypeCrud: EntityStatus.failure,
      ));
    }
  }

  FutureOr<void> _onPriorityTypeUpdateEvent(
      PriorityTypeUpdateEvent event, Emitter<PriorityTypeState> emit) async {
    emit(state.copyWith(
      priorityTypeCrud: EntityStatus.loading,
      priorityTypePage: 0,
    ));
    try {
      EntityResponse response =
          await priorityTypeRepository.updatePriorityType(event.priorityType);
      debugPrint("Update issue: >>> Hitting API");
      if (response.isSuccess) {
        List<PriorityType> priorityTypeList =
            await priorityTypeRepository.getAllPriorityTypes();
        emit(state.copyWith(
          priorityTypeList: priorityTypeList,
          selectedPriorityType: event.priorityType,
          priorityTypeCrud: EntityStatus.success,
          message: response.message,
          priorityTypePage: 0,
        ));
      } else {
        debugPrint("Update issue: >>>");
        emit(state.copyWith(
          priorityTypeList: null,
          selectedPriorityType: event.priorityType,
          message: response.message,
          priorityTypeCrud: EntityStatus.failure,
          priorityTypePage: 2,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityTypeList: const [],
        selectedPriorityType: event.priorityType,
        message: e.toString(),
        priorityTypeCrud: EntityStatus.failure,
        priorityTypePage: 2,
      ));
    }
  }

  FutureOr<void> _onPriorityTypeDeleteEvent(
      PriorityTypeDeleteEvent event, Emitter<PriorityTypeState> emit) async {
    emit(state.copyWith(
      priorityTypeCrud: EntityStatus.loading,
      priorityTypePage: 0,
    ));
    int deletedIndex =
        state.priorityTypeList.indexWhere((element) => element.id == event.id);
    try {
      EntityResponse response =
          await priorityTypeRepository.deletePriorityType(event.id);
      if (response.isSuccess) {
        state.priorityTypeList.removeAt(deletedIndex);

        emit(state.copyWith(
          priorityTypeCrud: EntityStatus.success,
          message: response.message,
          priorityTypeList: state.priorityTypeList,
          priorityTypePage: 0,
        ));
        //add(PriorityTypeLoadingEvent());
      } else {
        emit(state.copyWith(
          priorityTypeList: state.priorityTypeList,
          selectedPriorityType: state.priorityTypeList.elementAt(deletedIndex),
          message: response.message,
          priorityTypeCrud: EntityStatus.failure,
          priorityTypePage: 3,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        priorityTypeList: state.priorityTypeList,
        selectedPriorityType: state.priorityTypeList.elementAt(deletedIndex),
        message: e.toString(),
        priorityTypeCrud: EntityStatus.failure,
        priorityTypePage: 3,
      ));
      debugPrint("Error while deleting severity level : $e");
    }
  }

  FutureOr<void> _onselectedPriorityTypeEvent(
      selectedPriorityTypeEvent event, Emitter<PriorityTypeState> emit) async {
    try {
      emit(state.copyWith(
        selectedPriorityType: event.priorityType,
        priorityTypeCrud: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedPriorityType: null,
        priorityTypeCrud: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
