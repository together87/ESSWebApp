part of 'add_edit_site_bloc.dart';

class AddEditSiteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEditSiteNameChanged extends AddEditSiteEvent {
  final String name;
  AddEditSiteNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class AddEditSiteCodeChanged extends AddEditSiteEvent {
  final String code;
  AddEditSiteCodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}

class AddEditSiteReferenceChanged extends AddEditSiteEvent {
  final String reference;
  AddEditSiteReferenceChanged({required this.reference});

  @override
  List<Object> get props => [reference];
}

class AddEditSiteRegionsListLoadingEvent extends AddEditSiteEvent {}

class AddEditSiteJSAMethodListLoadingEvent extends AddEditSiteEvent {}

class AddEditRegionSelectedEvent extends AddEditSiteEvent {
  String? subRegion;
  int? subRegionId;
  AddEditRegionSelectedEvent({required this.subRegion, required this.subRegionId});
}

class AddEditGetTimezonesEvent extends AddEditSiteEvent {
  int? subRegionId;
  AddEditGetTimezonesEvent({required this.subRegionId});
}

class AddEditTimezoneSelectedEvent extends AddEditSiteEvent {
  TimeZone timezone;
  AddEditTimezoneSelectedEvent({required this.timezone});
}

class AddEditJsaMethodSelectedEvent extends AddEditSiteEvent {
  JsaMethod jsaMethod;
  AddEditJsaMethodSelectedEvent({required this.jsaMethod});
}

class CreateSitesEvent extends AddEditSiteEvent {}

class UpdateSitesEvent extends AddEditSiteEvent {
  int? siteId;
  UpdateSitesEvent({required this.siteId});
}

class AddEditSiteJSAReviewRequiredStatusStatusChanged extends AddEditSiteEvent {
  final bool jsaArchiveReviewStatus;
  AddEditSiteJSAReviewRequiredStatusStatusChanged({required this.jsaArchiveReviewStatus});

  @override
  List<Object> get props => [jsaArchiveReviewStatus];
}

class AddEditSiteLoaded extends AddEditSiteEvent {
  final String siteId;
  AddEditSiteLoaded({required this.siteId});
  @override
  List<Object> get props => [siteId];
}
