import 'dart:async';
import '../../../../../common_libraries.dart';
import '../../../../../constants/app_strings.dart';
import '../../severity_level/data/model/severityLevel.dart';
import '../../severity_level/data/repository/severity_level_repository.dart';
import '../data/model/observation_type_response.dart';
import '../data/model/visibility_type.dart';
import '../data/repository/observation_type_repository.dart';
import 'observation_type_event.dart';
import 'observation_type_state.dart';

class ObservationTypeBloc
    extends Bloc<ObservationTypeEvents, ObservationTypeState> {
  final ObservationTypeRepository observationTypeRepository;
  final SeverityLevelRepository severityLevelRepository;

  ObservationTypeBloc(
      {required this.observationTypeRepository,
      required this.severityLevelRepository})
      : super(const ObservationTypeState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<CreateNewObservationTypeEvent>(_onCreateNewObservationTypeEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdateObservationTypeEvent>(_onUpdateObservationTypeEvent);
    on<ObservationTypeSelectedEvent>(_onObservationTypeSelectedEvent);
    on<DeleteObservationTypeEvent>(_onDeleteObservationTypeEvent);
    on<ObservationTypeLoadingEvent>(_onObservationTypeLoadingEvent);
    on<GetObservationTypeByIdEvent>(_ongetObservationTypeByIdEvent);
    on<CreateObservationTypeEvent>(_onCreateObservationTypeEvent);
    on<SeverityLevelSelectedEvent>(_onSeverityLevelSelectedEvent);
    on<VisibilityTypeSelectedEvent>(_onVisibilityTypeSelectedEvent);
  }

  FutureOr<void> _onCreateNewObservationTypeEvent(
      CreateNewObservationTypeEvent event,
      Emitter<ObservationTypeState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response = await observationTypeRepository
          .createObservationType(event.observationType);
      if (response.isSuccess) {
        List<ObservationType> observationTypeList =
            await observationTypeRepository.getAllObservationTypes();
        emit(state.copyWith(
          observationTypeList: observationTypeList,
          selectedObservationType: observationTypeList.first,
          crudStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          observationTypeList: null,
          selectedObservationType: null,
          crudStatus: EntityStatus.failure,
          message: response.message,
          page: 1,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeList: null,
        selectedObservationType: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
        page: 1,
      ));
    }
  }

  FutureOr<void> _onPageChangeEvent(
      PageChangeEvent event, Emitter<ObservationTypeState> emit) {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));

    try {
      SeverityLevel severityLevel = SeverityLevel(
        id: event.observationType!.severityLevelId,
        level: event.observationType!.severityLevel,
      );
      VisibilityType visibilityType = VisibilityType(
        id: event.observationType!.visibilityTypeId,
        name: event.observationType!.visibilityType,
      );
      emit(state.copyWith(
        page: event.page,
        crudStatus: EntityStatus.success,
        message: null,
        selectedObservationType: event.observationType,
        selectedSeverityLevel: severityLevel,
        selectedVisibilityType: visibilityType,
      ));
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        crudStatus: EntityStatus.failure,
        message: null,
      ));
    }
  }

  FutureOr<void> _onUpdateObservationTypeEvent(UpdateObservationTypeEvent event,
      Emitter<ObservationTypeState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response = await observationTypeRepository
          .updateObservationType(event.observationType);
      if (response.isSuccess) {
        List<ObservationType> observationTypeList =
            await observationTypeRepository.getAllObservationTypes();
        emit(state.copyWith(
          observationTypeList: observationTypeList,
          selectedObservationType: event.observationType,
          selectedSeverityLevel: state.selectedSeverityLevel,
          selectedVisibilityType: state.selectedVisibilityType,
          crudStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          observationTypeList: null,
          selectedObservationType: null,
          crudStatus: EntityStatus.failure,
          message: response.message,
          page: 2,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeList: null,
        selectedObservationType: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
        page: 2,
      ));
    }
  }

  FutureOr<void> _onObservationTypeSelectedEvent(
      ObservationTypeSelectedEvent event, Emitter<ObservationTypeState> emit) {
    try {
      emit(state.copyWith(
        selectedObservationType: event.observationType,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedObservationType: null,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  FutureOr<void> _onSeverityLevelSelectedEvent(
      SeverityLevelSelectedEvent event, Emitter<ObservationTypeState> emit) {
    try {
      emit(state.copyWith(
        selectedSeverityLevel: event.severityLevel,
        selectedVisibilityType: state.selectedVisibilityType,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedSeverityLevel: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onVisibilityTypeSelectedEvent(
      VisibilityTypeSelectedEvent event, Emitter<ObservationTypeState> emit) {
    try {
      emit(state.copyWith(
        selectedVisibilityType: event.visibilityType,
        selectedSeverityLevel: state.selectedSeverityLevel,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedVisibilityType: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onDeleteObservationTypeEvent(DeleteObservationTypeEvent event,
      Emitter<ObservationTypeState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response =
          await observationTypeRepository.deleteObservationType(event.id);
      if (response.isSuccess) {
        List<ObservationType> observationTypeList =
            await observationTypeRepository.getAllObservationTypes();
        if (observationTypeList.isNotEmpty) {
          emit(state.copyWith(
            observationTypeList: observationTypeList,
            selectedObservationType: observationTypeList.first,
            crudStatus: EntityStatus.success,
            message: response.message,
          ));
        } else {
          emit(state.copyWith(
            observationTypeList: const [],
            crudStatus: EntityStatus.success,
            message: response.message,
          ));
        }
      } else {
        emit(state.copyWith(
          observationTypeList: null,
          selectedObservationType: null,
          crudStatus: EntityStatus.failure,
          message: response.message,
          page: 3,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        observationTypeList: null,
        selectedObservationType: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
        page: 3,
      ));
    }
  }

  FutureOr<void> _onObservationTypeLoadingEvent(
      ObservationTypeLoadingEvent event,
      Emitter<ObservationTypeState> emit) async {
    emit(state.copyWith(crudStatus: EntityStatus.loading));

    try {
      List<ObservationType> observationTypeList =
          await observationTypeRepository.getAllObservationTypes();
      List<VisibilityType> visiblityTypeList =
          await observationTypeRepository.getAllVisibilityTypes();
      List<SeverityLevel> severityLevelList =
          await severityLevelRepository.getAllSeverityLevels();
      if (observationTypeList.isNotEmpty) {
        if (visiblityTypeList.isNotEmpty && severityLevelList.isNotEmpty) {
          emit(state.copyWith(
            page: 0,
            observationTypeList: observationTypeList,
            severityLevelList: severityLevelList,
            visibilityTypeList: visiblityTypeList,
            selectedObservationType: observationTypeList.first,
            selectedSeverityLevel: null,
            selectedVisibilityType: null,
            crudStatus: EntityStatus.success,
          ));
        } else {
          emit(state.copyWith(
            page: 0,
            observationTypeList: const [],
            severityLevelList: const [],
            visibilityTypeList: const [],
            selectedObservationType: null,
            selectedSeverityLevel: null,
            selectedVisibilityType: null,
            crudStatus: EntityStatus.failure,
          ));
        }
      } else {
        emit(state.copyWith(
          page: 0,
          observationTypeList: const [],
          severityLevelList: const [],
          visibilityTypeList: const [],
          selectedObservationType: null,
          selectedSeverityLevel: null,
          selectedVisibilityType: null,
          crudStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all Observation Types : $e");
    }
  }

  FutureOr<void> _ongetObservationTypeByIdEvent(
      GetObservationTypeByIdEvent event,
      Emitter<ObservationTypeState> emit) async {}

  FutureOr<void> _onCreateObservationTypeEvent(CreateObservationTypeEvent event,
      Emitter<ObservationTypeState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
    ));
    try {
      List<VisibilityType> visiblityTypeList =
          await observationTypeRepository.getAllVisibilityTypes();
      List<SeverityLevel> severityLevelList =
          await severityLevelRepository.getAllSeverityLevels();
      if (severityLevelList.isNotEmpty && visiblityTypeList.isNotEmpty) {
        emit(state.copyWith(
          page: event.page,
          severityLevelList: severityLevelList,
          selectedSeverityLevel: null,
          visibilityTypeList: visiblityTypeList,
          selectedVisibilityType: null,
          crudStatus: EntityStatus.success,
        ));
      } else {
        if (severityLevelList.isEmpty) {
          emit(state.copyWith(
              page: 0,
              severityLevelList: const [],
              visibilityTypeList: const [],
              crudStatus: EntityStatus.failure,
              message: AppStrings.noSeverityLevel));
        } else if (visiblityTypeList.isEmpty) {
          emit(state.copyWith(
              page: 0,
              severityLevelList: const [],
              visibilityTypeList: const [],
              crudStatus: EntityStatus.failure,
              message: AppStrings.noVisibilityType));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all Observation Types: $e");
    }
  }
}
