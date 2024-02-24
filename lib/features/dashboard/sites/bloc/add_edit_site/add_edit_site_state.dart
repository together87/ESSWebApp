part of 'add_edit_site_bloc.dart';

class AddEditSiteState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoaded;
  final String message;
  final String title;

  final List<Regions> regionsList;
  final List<TimeZone> timezoneList;
  final List<JsaMethod> jsaMethodList;

  /// Filed site add-edit
  final String siteName;
  final String siteCode;
  final bool jsaArchiveReviewStatus;
  final String reference;
  final TimeZone? selectedTimezone;
  final JsaMethod? selectedJsaMethod;

  /// Validation Message
  final String siteNameValidationMessage;
  final String siteCodeValidationMessage;
  final String siteReferenceValidationMessage;
  final String timezoneValidationMessage;
  final String jsaMethodValidationMessage;
  final String regionValidationMessage;

  final String selectedSubregion;
  final int? selectedSubregionId;

  const AddEditSiteState({
    this.status = EntityStatus.initial,
    this.detailsLoaded = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.siteName = '',
    this.siteCode = '',
    this.jsaArchiveReviewStatus = false,
    this.siteNameValidationMessage = '',
    this.siteCodeValidationMessage = '',
    this.siteReferenceValidationMessage = '',
    this.timezoneValidationMessage = '',
    this.jsaMethodValidationMessage = '',
    this.regionValidationMessage = '',
    this.reference = '',
    this.regionsList = const [],
    this.timezoneList = const [],
    this.jsaMethodList = const [],
    this.selectedSubregion = '',
    this.selectedSubregionId,
    this.selectedTimezone,
    this.selectedJsaMethod,
  });

  bool get formDirty => true;

  @override
  List<Object?> get props => [
        status,
        detailsLoaded,
        message,
        title,
        siteName,
        siteCode,
        jsaArchiveReviewStatus,
        siteNameValidationMessage,
        siteCodeValidationMessage,
        siteReferenceValidationMessage,
        timezoneValidationMessage,
        jsaMethodValidationMessage,
        regionValidationMessage,
        reference,
        regionsList,
        selectedSubregion,
        timezoneList,
        selectedTimezone,
        selectedSubregionId,
        jsaMethodList,
        selectedJsaMethod,
      ];

  AddEditSiteState copyWith({
    EntityStatus? status,
    EntityStatus? detailsLoaded,
    String? message,
    String? title,
    String? siteName,
    String? siteCode,
    bool? jsaArchiveReviewStatus,
    String? siteNameValidationMessage,
    String? siteCodeValidationMessage,
    String? siteReferenceValidationMessage,
    String? timezoneValidationMessage,
    String? regionValidationMessage,
    String? jsaMethodValidationMessage,
    String? reference,
    List<Regions>? regionsList,
    String? selectedSubregion,
    int? selectedSubregionId,
    List<JsaMethod>? jsaMethodList,
    List<TimeZone>? timezoneList,
    Nullable<TimeZone?>? selectedTimezone,
    Nullable<JsaMethod?>? selectedJsaMethod,
  }) {
    return AddEditSiteState(
      status: status ?? this.status,
      regionsList: regionsList ?? this.regionsList,
      detailsLoaded: detailsLoaded ?? this.detailsLoaded,
      message: message ?? this.message,
      title: title ?? this.title,
      siteName: siteName ?? this.siteName,
      siteCode: siteCode ?? this.siteCode,
      jsaArchiveReviewStatus:
          jsaArchiveReviewStatus ?? this.jsaArchiveReviewStatus,
      siteNameValidationMessage:
          siteNameValidationMessage ?? this.siteNameValidationMessage,
      siteCodeValidationMessage:
          siteCodeValidationMessage ?? this.siteCodeValidationMessage,
          siteReferenceValidationMessage:siteReferenceValidationMessage??this.siteReferenceValidationMessage,
      timezoneValidationMessage:
          timezoneValidationMessage ?? this.timezoneValidationMessage,
      jsaMethodValidationMessage:
          jsaMethodValidationMessage ?? this.jsaMethodValidationMessage,
      regionValidationMessage:
          regionValidationMessage ?? this.regionValidationMessage,
      reference: reference ?? this.reference,
      jsaMethodList: jsaMethodList ?? this.jsaMethodList,
      timezoneList: timezoneList ?? this.timezoneList,
      selectedSubregion: selectedSubregion ?? this.selectedSubregion,
      selectedSubregionId: selectedSubregionId ?? this.selectedSubregionId,
      selectedTimezone: selectedTimezone != null
          ? selectedTimezone.value
          : this.selectedTimezone,
      selectedJsaMethod: selectedJsaMethod != null
          ? selectedJsaMethod.value
          : this.selectedJsaMethod,
    );
  }
}
