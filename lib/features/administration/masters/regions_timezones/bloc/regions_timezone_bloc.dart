import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_event.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_state.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/region.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/sub_region.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone_create.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/repository/timezones_repository.dart';

import '../data/repository/regions_repository.dart';

class RegionsTimezoneBloc
    extends Bloc<RegionsTimezoneEvents, RegionsTimezoneState> {
  final RegionsRepository regionsRepository;
  final TimeZonesRepository timeZoneRepository;

  RegionsTimezoneBloc(
      {required this.regionsRepository, required this.timeZoneRepository})
      : super(const RegionsTimezoneState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<LoadMainRegionsEvent>(_onLoadMainRegionsEvent);
    on<LoadCreateTimezonesEvent>(_onLoadCreateTimezonesEvent);
    on<RegionChangedEvent>(_onRegionChangedEvent);
    on<LoadSubRegionEvent>(_onLoadSubRegionEvent);
    on<LoadAssociatedTimezoneEvent>(_onLoadAssociatedTimezoneEvent);
    on<CreateRegionEvent>(_onCreateRegionEvent);
    on<UpdateRegionEvent>(_onUpdateRegionEvent);
    on<DeleteRegionEvent>(_onDeleteRegionEvent);
    on<CreateTimezoneChangedEvent>(_onCreateTimezoneChangedEvent);
    on<CreateTimezoneEvent>(_onCreateTimezoneEvent);
    on<ShowHideCreateRegionForm>(_onShowHideCreateRegionForm);
    on<ShowHideCreateTimezoneForm>(_onShowHideCreateTimezoneForm);
    on<RegionPageChangedEvent>(_onRegionPageChanged);
    on<TimezonePageChangedEvent>(_onTimezonePageChanged);
    on<UpdateTimezoneEvent>(_onUpdateTimezoneEvent);
    on<DeleteTimezoneEvent>(_onDeleteTimezoneEvent);
    on<TextfieldChangedEvent>(_onTextfieldChangedEvent);
  }

  FutureOr<void> _onLoadMainRegionsEvent(
      LoadMainRegionsEvent event, Emitter<RegionsTimezoneState> emit) async {
    try {
      emit(state.copyWith(regionCrudStatus: EntityStatus.loading));
      List<Region> regionList = await regionsRepository.getAllRegions();
      if (regionList.isNotEmpty) {
        emit(state.copyWith(
            regionList: regionList,
            selectedRegion: regionList[0],
            timezoneList: const [],
            selectedSubRegion: null,
            timezoneCrudStatus: EntityStatus.failure,
            regionPage: 0,
            regionCrudStatus: EntityStatus.success));
        add(RegionChangedEvent(region: regionList[0]));
      } else {
        emit(state.copyWithNull(
            regionList: const [],
            selectedRegion: null,
            timezoneList: const [],
            selectedSubRegion: null,
            regionPage: 0,
            timezoneCrudStatus: EntityStatus.failure,
            regionCrudStatus: EntityStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          timezoneCrudStatus: EntityStatus.failure,
          message: e.toString(),
          regionPage: 0));
      debugPrint("Error while loading all regions: $e");
    }
  }

  FutureOr<void> _onLoadCreateTimezonesEvent(LoadCreateTimezonesEvent event,
      Emitter<RegionsTimezoneState> emit) async {
    try {
      if ((state.selectedRegion != null) && (state.selectedSubRegion != null)) {
        emit(state.copyWith(
          timezoneCrudStatus: EntityStatus.loading,
        ));
        List<TimeZone> timezoneCreateList = await regionsRepository
            .getCreateTimezonesForRegion(state.selectedRegion!.id!);
        TimeZone? selected;
        if (timezoneCreateList.isNotEmpty) {
          selected = timezoneCreateList.first;
          emit(state.copyWith(
            timezoneCreateList: timezoneCreateList,
            selectedTimezoneCreate: selected,
            timezonePage: event.page,
            selectedSubRegion: state.selectedSubRegion,
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.success,
          ));
        } else {
          emit(state.copyWithNull(
            timezoneCreateList: const [],
            selectedTimezoneCreate: null,
            timezonePage: 1,
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure,
          ));
        }
      } else {
        emit(state.copyWith(
          timezonePage: 1,
          regionCrudStatus: EntityStatus.failure,
          timezoneCrudStatus: EntityStatus.failure,
          message: "Please select a subregion to create a time zone.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        timezonePage: 0,
        regionCrudStatus: EntityStatus.failure,
        timezoneCrudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all timezonecreatelist: $e");
    }
  }

  FutureOr<void> _onRegionChangedEvent(
      RegionChangedEvent event, Emitter<RegionsTimezoneState> emit) {
    emit(state.copyWithNull(
      selectedRegion: event.region,
      selectedSubRegion: null,
    ));
    add(LoadSubRegionEvent(subRegionId: event.region.id!));
  }

  FutureOr<void> _onLoadSubRegionEvent(
      LoadSubRegionEvent event, Emitter<RegionsTimezoneState> emit) async {
    try {
      emit(state.copyWith(regionCrudStatus: EntityStatus.loading));
      List<SubRegion> subRegionList =
          await regionsRepository.getSubRegiForRegion(event.subRegionId);
      // Loading timezones of first sub-region
      if (subRegionList.isNotEmpty) {
        add(LoadAssociatedTimezoneEvent(
          subRegion: state.selectedSubRegion ?? subRegionList.first,
        ));

        emit(state.copyWith(
            subRegionList: subRegionList,
            selectedSubRegion: subRegionList.first,
            timezoneCrudStatus: EntityStatus.failure,
            regionCrudStatus: EntityStatus.success));
      } else {
        emit(state.copyWithNull(
          subRegionList: const [],
          selectedSubRegion: null,
          timezoneList: const [],
          timezoneCreateList: const [],
          timezoneCrudStatus: EntityStatus.failure,
          regionCrudStatus: EntityStatus.failure,
          selectedTimezone: null,
          timezonePage: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          timezoneCrudStatus: EntityStatus.failure,
          message: e.toString(),
          regionPage: 0));
      debugPrint("Error while loading all sub regions: $e");
    }
  }

  FutureOr<void> _onLoadAssociatedTimezoneEvent(
      LoadAssociatedTimezoneEvent event,
      Emitter<RegionsTimezoneState> emit) async {
    try {
      emit(state.copyWith(
        timezoneCrudStatus: EntityStatus.loading,
        timezonePage: 0,
      ));
      List<TimeZone> timezones =
          await regionsRepository.getTimeZonesForRegion(event.subRegion.id!);
      // Making first timezone default
      TimeZone? selected;
      if (timezones.isNotEmpty) {
        selected = timezones.first;
        emit(state.copyWith(
            timezoneList: timezones,
            selectedTimezone: selected,
            selectedSubRegion: event.subRegion,
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.success));
      } else {
        emit(state.copyWithNull(
            timezoneList: const [],
            selectedTimezone: null,
            selectedSubRegion: event.subRegion,
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
        timezonePage: 0,
        regionCrudStatus: EntityStatus.failure,
        timezoneCrudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading associated timezones: $e");
    }
  }

  FutureOr<void> _onCreateRegionEvent(
      CreateRegionEvent event, Emitter<RegionsTimezoneState> emit) async {
    try {
      if (state.selectedRegion != null) {
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.loading, regionPage: 0));

        EntityResponse response =
            await regionsRepository.addSubRegion(event.subRegion);
        if (response.isSuccess) {
          // Loading sub
          List<SubRegion> subRegionList = await regionsRepository
              .getSubRegiForRegion(state.selectedRegion?.id ?? 0);
          emit(state.copyWith(
            regionCrudStatus: EntityStatus.success,
            timezoneCrudStatus: EntityStatus.failure,
            selectedRegion: state.selectedRegion,
            subRegionList: subRegionList,
            selectedSubRegion: subRegionList.first,
            message: response.message,
            regionPage: 0,
            // regionList: regionList
          ));
        } else {
          emit(state.copyWith(
              regionCrudStatus: EntityStatus.failure,
              timezoneCrudStatus: EntityStatus.failure,
              message: response.message,
              regionPage: 1));
        }
        add(LoadSubRegionEvent(subRegionId: state.selectedRegion!.id!));
      } else {
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure,
            message: "Please select a region",
            regionPage: 1));
      }
    } catch (e) {
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          timezoneCrudStatus: EntityStatus.failure,
          message: e.toString(),
          regionPage: 1));
      debugPrint("Error while adding sub regions: $e");
    }
  }

  FutureOr<void> _onUpdateRegionEvent(
      UpdateRegionEvent event, Emitter<RegionsTimezoneState> emit) async {
    try {
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.loading, regionPage: 0));

      EntityResponse response =
          await regionsRepository.editSubRegion(event.subRegion);

      if (response.isSuccess) {
        List<SubRegion> subRegionList = await regionsRepository
            .getSubRegiForRegion(state.selectedRegion?.id ?? 0);
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.success,
            timezoneCrudStatus: EntityStatus.failure,
            message: response.message,
            regionPage: 0,
            subRegionList: subRegionList));
      } else {
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure,
            message: response.message,
            regionPage: 2));
      }

      add(LoadSubRegionEvent(subRegionId: state.selectedRegion!.id!));
    } catch (e) {
      emit(state.copyWith(
        regionPage: 2,
        message: e.toString(),
        regionCrudStatus: EntityStatus.failure,
        timezoneCrudStatus: EntityStatus.failure,
      ));
      debugPrint("Error while updating sub region: $e");
    }
  }

  FutureOr<void> _onDeleteRegionEvent(
      DeleteRegionEvent event, Emitter<RegionsTimezoneState> emit) async {
    int deletedIndex =
        state.subRegionList.indexWhere((element) => element.id == event.id);
    try {
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.loading, regionPage: 0));
      EntityResponse response =
          await regionsRepository.deleteSubRegion(event.id);

      if (response.isSuccess) {
        state.subRegionList.removeAt(deletedIndex);

        emit(state.copyWith(
          regionCrudStatus: EntityStatus.success,
          timezoneCrudStatus: EntityStatus.failure,
          subRegionList: state.subRegionList,
          selectedSubRegion:
              state.subRegionList.isEmpty ? null : state.subRegionList.first,
          message: response.message,
          regionPage: 0,
        ));
        if (state.subRegionList.isEmpty) {
          emit(state.copyWith(
            timezoneList: const [],
          ));
        } else {
          add(LoadAssociatedTimezoneEvent(
              subRegion: state.subRegionList.first));
        }
      } else {
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure,
            message: response.message,
            regionPage: 3));
      }
      // add(LoadSubRegionEvent(subRegionId: state.selectedRegion!.id!));
    } catch (e) {
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          timezoneCrudStatus: EntityStatus.failure,
          message: e.toString(),
          regionPage: 3));
      debugPrint("Error while deleting sub region: $e");
    }
  }

  FutureOr<void> _onShowHideCreateRegionForm(
      ShowHideCreateRegionForm event, Emitter<RegionsTimezoneState> emit) {}

  FutureOr<void> _onShowHideCreateTimezoneForm(
      ShowHideCreateTimezoneForm event, Emitter<RegionsTimezoneState> emit) {}

  FutureOr<void> _onCreateTimezoneEvent(
      CreateTimezoneEvent event, Emitter<RegionsTimezoneState> emit) async {
    try {
      emit(state.copyWith(
        timezoneCrudStatus: EntityStatus.loading,
        timezonePage: 0,
      ));
      EntityResponse response =
          await regionsRepository.addTimezone(event.timeZoneCreate);
      if (response.isSuccess) {
        emit(state.copyWith(
          timezoneCrudStatus: EntityStatus.success,
          message: response.message,
          timezonePage: 0,
        ));
        add(LoadAssociatedTimezoneEvent(subRegion: state.selectedSubRegion!));
      } else {
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure,
            message: response.message,
            timezonePage: 1));
      }
    } catch (e) {
      emit(state.copyWith(
        timezonePage: 1,
        regionCrudStatus: EntityStatus.failure,
        timezoneCrudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while adding timezone: $e");
    }
  }

  FutureOr<void> _onUpdateTimezoneEvent(
      UpdateTimezoneEvent event, Emitter<RegionsTimezoneState> emit) async {
    try {
      emit(state.copyWith(
        timezoneCrudStatus: EntityStatus.loading,
        timezonePage: 0,
      ));
      EntityResponse response =
          await regionsRepository.editTimezone(event.timeZone);
      emit(state.copyWith(
          regionCrudStatus: EntityStatus.failure,
          timezoneCrudStatus:
              response.isSuccess ? EntityStatus.success : EntityStatus.failure,
          message: response.message,
          timezonePage: 0,
          timezoneList: <TimeZone>[]));
      add(LoadAssociatedTimezoneEvent(subRegion: state.selectedSubRegion!));
    } catch (e) {
      emit(state.copyWith(
        timezonePage: 0,
        regionCrudStatus: EntityStatus.failure,
        timezoneCrudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while updating timezone: $e");
    }
  }

  FutureOr<void> _onDeleteTimezoneEvent(
      DeleteTimezoneEvent event, Emitter<RegionsTimezoneState> emit) async {
    int deletedIndex =
        state.timezoneList.indexWhere((element) => element.id == event.id);
    try {
      emit(state.copyWith(
        timezoneCrudStatus: EntityStatus.loading,
        timezonePage: 0,
      ));
      EntityResponse response =
          await regionsRepository.deleteTimezone(event.id);

      if (response.isSuccess) {
        state.timezoneList.removeAt(deletedIndex);

        emit(state.copyWith(
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.success,
            timezoneList: state.timezoneList,
            message: response.message,
            timezonePage: 0));
      } else {
        emit(state.copyWith(
            regionCrudStatus: EntityStatus.failure,
            timezoneCrudStatus: EntityStatus.failure,
            message: response.message,
            timezonePage: 3));
      }
      // add(LoadAssociatedTimezoneEvent(subRegion: state.selectedSubRegion!));
    } catch (e) {
      emit(state.copyWith(
        timezonePage: 3,
        regionCrudStatus: EntityStatus.failure,
        timezoneCrudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while deleting timezone: $e");
    }
  }

  FutureOr<void> _onCreateTimezoneChangedEvent(CreateTimezoneChangedEvent event,
      Emitter<RegionsTimezoneState> emit) async {
    emit(state.copyWith(selectedTimezoneCreate: event.timezone));
    emit(state.copyWith());
  }

  FutureOr<void> _onRegionPageChanged(
      RegionPageChangedEvent event, Emitter<RegionsTimezoneState> emit) async {
    emit(state.copyWith(
      regionCrudStatus: EntityStatus.loading,
      timezoneCrudStatus: EntityStatus.failure,
    ));
    emit(state.copyWith(
      regionPage: event.page,
      selectedSubRegion: event.subRegion ?? state.selectedSubRegion,
    ));
    emit(state.copyWith(
      regionCrudStatus: EntityStatus.failure,
      timezoneCrudStatus: EntityStatus.failure,
    ));
  }

  FutureOr<void> _onTimezonePageChanged(TimezonePageChangedEvent event,
      Emitter<RegionsTimezoneState> emit) async {
    emit(state.copyWith(
      regionCrudStatus: EntityStatus.failure,
      timezonePage: event.page,
      selectedTimezone: event.timeZone,
      timezoneCrudStatus: EntityStatus.failure,
    ));
  }

  FutureOr<void> _onTextfieldChangedEvent(
      TextfieldChangedEvent event, Emitter<RegionsTimezoneState> emit) {
    emit(state.copyWith(
      selectedSubRegion: event.changedSubregion,
    ));
  }
}
