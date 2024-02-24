import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/region.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/sub_region.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone_create.dart';

class RegionsTimezoneEvents extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadMainRegionsEvent extends RegionsTimezoneEvents {}

class LoadTimeZonesEvent extends RegionsTimezoneEvents {
  final Region region;
  LoadTimeZonesEvent({required this.region});
}

class LoadCreateTimezonesEvent extends RegionsTimezoneEvents {
  final int page;
  LoadCreateTimezonesEvent({required this.page});
}

class RegionChangedEvent extends RegionsTimezoneEvents {
  final Region region;

  RegionChangedEvent({required this.region});
}

class LoadSubRegionEvent extends RegionsTimezoneEvents {
  final int subRegionId;

  LoadSubRegionEvent({required this.subRegionId});
}

class LoadAssociatedTimezoneEvent extends RegionsTimezoneEvents {
  final SubRegion subRegion;

  LoadAssociatedTimezoneEvent({required this.subRegion});
}

class CreateRegionEvent extends RegionsTimezoneEvents {
  final SubRegion subRegion;
  CreateRegionEvent({required this.subRegion});
}

class TextfieldChangedEvent extends RegionsTimezoneEvents {
  final SubRegion? changedSubregion;
  TextfieldChangedEvent({required this.changedSubregion});
}

class UpdateRegionEvent extends RegionsTimezoneEvents {
  final SubRegion subRegion;
  UpdateRegionEvent({required this.subRegion});
}

class DeleteRegionEvent extends RegionsTimezoneEvents {
  final int id;
  DeleteRegionEvent({required this.id});
}

class ShowHideCreateRegionForm extends RegionsTimezoneEvents {
  final bool isCreateRegionFormVisible;

  ShowHideCreateRegionForm({required this.isCreateRegionFormVisible});
}

class ShowHideCreateTimezoneForm extends RegionsTimezoneEvents {
  final bool isCreateTimezoneFormVisible;

  ShowHideCreateTimezoneForm({required this.isCreateTimezoneFormVisible});
}

class SubRegionTextChanged extends RegionsTimezoneEvents {
  final String subRegion;

  SubRegionTextChanged({required this.subRegion});
}

class CreateTimezoneEvent extends RegionsTimezoneEvents {
  final TimeZoneCreate timeZoneCreate;

  CreateTimezoneEvent({required this.timeZoneCreate});
}

class CreateTimezoneChangedEvent extends RegionsTimezoneEvents {
  final TimeZone timezone;

  CreateTimezoneChangedEvent({required this.timezone});
}

class UpdateTimezoneEvent extends RegionsTimezoneEvents {
  final TimeZone timeZone;

  UpdateTimezoneEvent({required this.timeZone});
}

class DeleteTimezoneEvent extends RegionsTimezoneEvents {
  final int id;

  DeleteTimezoneEvent({required this.id});
}

class RegionPageChangedEvent extends RegionsTimezoneEvents {
  final int? page;
  SubRegion? subRegion;

  RegionPageChangedEvent({required this.page, this.subRegion});
}

class TimezonePageChangedEvent extends RegionsTimezoneEvents {
  final int page;
  TimeZone? timeZone;

  TimezonePageChangedEvent({required this.page, this.timeZone});
}
