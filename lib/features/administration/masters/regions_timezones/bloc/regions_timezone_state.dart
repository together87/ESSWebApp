import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone_create.dart';
import '../data/model/region.dart';
import '../data/model/sub_region.dart';

class RegionsTimezoneState extends Equatable {
  final List<Region> regionList;
  final List<SubRegion> subRegionList;
  final List<TimeZone> timezoneList;
  final List<TimeZone> timezoneCreateList;
  final EntityStatus regionCrudStatus;
  final EntityStatus timezoneCrudStatus;
  final String message;

  final Region? selectedRegion;
  final SubRegion? selectedSubRegion;
  final TimeZone? selectedTimezoneCreate;
  final TimeZone? selectedTimezone;
  final int regionPage; //0 if list, 1 if create, 2 if update, 3 if delete
  final int timezonePage; //0 if list, 1 if create, 2 if update, 3 if delete

  const RegionsTimezoneState(
      {this.regionList = const [],
      this.subRegionList = const [],
      this.timezoneList = const [],
      this.timezoneCreateList = const [],
      this.selectedRegion,
      this.selectedSubRegion,
      this.selectedTimezoneCreate,
      this.selectedTimezone,
      this.regionCrudStatus = EntityStatus.initial,
      this.timezoneCrudStatus = EntityStatus.initial,
      this.message = '',
      this.regionPage = 0,
      this.timezonePage = 0});

  @override
  List<Object?> get props => [
        regionList,
        subRegionList,
        selectedRegion,
        selectedTimezoneCreate,
        timezoneList,
        timezoneCreateList,
        regionCrudStatus,
        timezoneCrudStatus,
        message,
        regionPage,
        timezonePage,
        selectedSubRegion,
        selectedTimezone,
      ];

  RegionsTimezoneState copyWith(
      {List<Region>? regionList,
      List<SubRegion>? subRegionList,
      List<TimeZone>? timezoneList,
      List<TimeZone>? timezoneCreateList,
      Region? selectedRegion,
      TimeZone? selectedTimezoneCreate,
      EntityStatus? regionCrudStatus,
      EntityStatus? timezoneCrudStatus,
      String? message,
      SubRegion? selectedSubRegion,
      TimeZone? selectedTimezone,
      int? regionPage,
      int? timezonePage}) {
    return RegionsTimezoneState(
        regionList: regionList ?? this.regionList,
        subRegionList: subRegionList ?? this.subRegionList,
        timezoneList: timezoneList ?? this.timezoneList,
        timezoneCreateList: timezoneCreateList ?? this.timezoneCreateList,
        selectedRegion: selectedRegion ?? this.selectedRegion,
        message: message ?? '',
        regionCrudStatus: regionCrudStatus ?? this.regionCrudStatus,
        timezoneCrudStatus: timezoneCrudStatus ?? this.timezoneCrudStatus,
        selectedSubRegion: selectedSubRegion ?? this.selectedSubRegion,
        selectedTimezoneCreate:
            selectedTimezoneCreate ?? this.selectedTimezoneCreate,
        selectedTimezone: selectedTimezone ?? this.selectedTimezone,
        regionPage: regionPage ?? this.regionPage,
        timezonePage: timezonePage ?? this.timezonePage);
  }

  RegionsTimezoneState copyWithNull(
      {List<Region>? regionList,
      List<SubRegion>? subRegionList,
      List<TimeZone>? timezoneList,
      List<TimeZone>? timezoneCreateList,
      Region? selectedRegion,
      TimeZone? selectedTimezoneCreate,
      EntityStatus? regionCrudStatus,
      EntityStatus? timezoneCrudStatus,
      String? message,
      SubRegion? selectedSubRegion,
      TimeZone? selectedTimezone,
      int? regionPage,
      int? timezonePage}) {
    return RegionsTimezoneState(
        regionList: regionList ?? this.regionList,
        subRegionList: subRegionList ?? this.subRegionList,
        timezoneList: timezoneList ?? this.timezoneList,
        timezoneCreateList: timezoneCreateList ?? this.timezoneCreateList,
        selectedRegion: selectedRegion ?? this.selectedRegion,
        message: message ?? '',
        regionCrudStatus: regionCrudStatus ?? this.regionCrudStatus,
        timezoneCrudStatus: timezoneCrudStatus ?? this.timezoneCrudStatus,
        selectedSubRegion: selectedSubRegion,
        selectedTimezoneCreate: selectedTimezoneCreate,
        selectedTimezone: selectedTimezone,
        regionPage: regionPage ?? this.regionPage,
        timezonePage: timezonePage ?? this.timezonePage);
  }
}
