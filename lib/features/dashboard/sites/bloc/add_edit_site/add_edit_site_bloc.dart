import '../../../../administration/masters/regions_timezones/data/model/time_zone.dart';
import '../../data/repository/sites_repository.dart';
import '/common_libraries.dart';

part 'add_edit_site_event.dart';
part 'add_edit_site_state.dart';

class AddEditSiteBloc extends Bloc<AddEditSiteEvent, AddEditSiteState> {
  final BuildContext context;
  late SitesRepository sitesRepository;
  late FormDirtyBloc _formDirtyBloc;

  AddEditSiteBloc(this.context) : super(const AddEditSiteState()) {
    sitesRepository = RepositoryProvider.of(context);
    _formDirtyBloc = context.read<FormDirtyBloc>();
    _triggerEvents();
  }

  void _triggerEvents() {
    on<AddEditSiteNameChanged>(_onAddEditSiteNameChanged);
    on<AddEditSiteCodeChanged>(_onAddEditSiteCodeChanged);
    on<AddEditSiteLoaded>(_onAddEditSiteLoaded);
    on<AddEditSiteReferenceChanged>(_onAddEditSiteReferenceChanged);
    on<AddEditSiteRegionsListLoadingEvent>(
        _onAddEditSiteRegionsListLoadingEvent);
    on<AddEditSiteJSAMethodListLoadingEvent>(
        _onAddEditSiteJSAMethodListLoadingEvent);
    on<AddEditRegionSelectedEvent>(_onAddEditRegionSelectedEvent);
    on<AddEditGetTimezonesEvent>(_onAddEditGetTimezonesEvent);
    on<AddEditTimezoneSelectedEvent>(_onAddEditTimezoneSelectedEvent);
    on<AddEditJsaMethodSelectedEvent>(_onAddEditJsaMethodSelectedEvent);
    on<CreateSitesEvent>(_onCreateSitesEvent);
    on<UpdateSitesEvent>(_onUpdateSitesEvent);
    on<AddEditSiteJSAReviewRequiredStatusStatusChanged>(
        _onAddEditSiteJSAReviewRequiredStatusStatusChanged);
  }

  Future<void> _onAddEditSiteLoaded(
    AddEditSiteLoaded event,
    Emitter<AddEditSiteState> emit,
  ) async {
    emit(state.copyWith(detailsLoaded: EntityStatus.loading));

    try {
      Sites sites = await sitesRepository.getSitesById(event.siteId);
      add(AddEditGetTimezonesEvent(subRegionId: sites.regionId));
      emit(state.copyWith(
        siteName: sites.name.toString(),
        siteCode: sites.siteCode.toString(),
        jsaArchiveReviewStatus: sites.jsaArchiveReview,
        reference: sites.referenceCode,
        selectedJsaMethod: Nullable.value(
            JsaMethod(id: sites.jsaMethodId, name: sites.jsaMethod)),
        selectedSubregionId: sites.regionId,
        selectedSubregion: sites.regionName,
        selectedTimezone: Nullable.value(TimeZone(
          id: sites.timeZoneId,
          timeZoneId: sites.timeZoneId,
          timeZoneName: sites.timeZoneName,
          subRegionId: sites.regionId,
        )),
        detailsLoaded: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          detailsLoaded: EntityStatus.failure,
          message: "Failed to get project details"));
    }
  }

  Future<void> _onAddEditJsaMethodSelectedEvent(
      AddEditJsaMethodSelectedEvent event,
      Emitter<AddEditSiteState> emit) async {
    try {
      emit(state.copyWith(
        selectedJsaMethod: Nullable.value(event.jsaMethod),
        jsaMethodValidationMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(selectedJsaMethod: null));
    }
  }

  Future<void> _onAddEditRegionSelectedEvent(
      AddEditRegionSelectedEvent event, Emitter<AddEditSiteState> emit) async {
    try {
      add(AddEditGetTimezonesEvent(subRegionId: event.subRegionId));
      emit(state.copyWith(
        selectedSubregion: event.subRegion,
        selectedSubregionId: event.subRegionId,
        regionValidationMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedSubregion: null,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onAddEditGetTimezonesEvent(
      AddEditGetTimezonesEvent event, Emitter<AddEditSiteState> emit) async {
    List<TimeZone> timezoneList =
        await sitesRepository.getTimezones(event.subRegionId!);
    try {
      if (timezoneList.isNotEmpty) {
        emit(state.copyWith(
          timezoneList: timezoneList,
          selectedTimezone: Nullable.value(timezoneList.first),
        ));
      } else {
        emit(state.copyWith(
          timezoneList: const [],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
      ));
      debugPrint("Error while loading timezones for the subRegion: $e");
    }
  }

  Future<void> _onAddEditTimezoneSelectedEvent(
      AddEditTimezoneSelectedEvent event,
      Emitter<AddEditSiteState> emit) async {
    try {
      emit(state.copyWith(
        selectedTimezone: Nullable.value(event.timezone),
        timezoneValidationMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(selectedTimezone: null));
    }
  }

  Future<void> _onAddEditSiteRegionsListLoadingEvent(
    AddEditSiteRegionsListLoadingEvent event,
    Emitter<AddEditSiteState> emit,
  ) async {
    try {
      List<Regions> regionsList = await sitesRepository.getRegions();

      emit(state.copyWith(
        regionsList: regionsList,
      ));
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
      ));
    }
  }

  Future<void> _onAddEditSiteJSAMethodListLoadingEvent(
    AddEditSiteJSAMethodListLoadingEvent event,
    Emitter<AddEditSiteState> emit,
  ) async {
    try {
      List<JsaMethod> jsaMethodList = await sitesRepository.getJsaMethods();

      emit(state.copyWith(
        jsaMethodList: jsaMethodList,
        selectedJsaMethod: Nullable.value(jsaMethodList.first),
      ));
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
      ));
    }
  }

  void _onAddEditSiteNameChanged(
    AddEditSiteNameChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      siteName: event.name,
      siteNameValidationMessage: '',
    ));
    // _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditSiteCodeChanged(
    AddEditSiteCodeChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      siteCode: event.code,
      siteCodeValidationMessage: '',
    ));
  }

  void _onAddEditSiteReferenceChanged(
    AddEditSiteReferenceChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      reference: event.reference,
      siteReferenceValidationMessage: '',
    ));
  }

  void _onAddEditSiteJSAReviewRequiredStatusStatusChanged(
    AddEditSiteJSAReviewRequiredStatusStatusChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      jsaArchiveReviewStatus: event.jsaArchiveReviewStatus,
    ));
  }

  Future<void> _onCreateSitesEvent(
      CreateSitesEvent event, Emitter<AddEditSiteState> emit) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await sitesRepository.createSites(Sites(
          name: state.siteName,
          sanitizedName: state.siteName,
          siteCode: state.siteCode,
          sanitizedCode: state.siteCode,
          referenceCode: state.reference,
          active: true,
          jsaArchiveReview: state.jsaArchiveReviewStatus,
          jsaMethodId: state.selectedJsaMethod!.id,
          timeZoneId: state.selectedTimezone!.timeZoneId,
          regionId: state.selectedSubregionId,
        ));
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            title: 'Success',
            message: "Site added successfully.",
          ));
        } else if (response.statusCode == 409) {
          emit(state.copyWith(
              message: response.message,
              title: 'Failure',
              status: EntityStatus.failure));
        } else {
          emit(state.copyWith(
            status: EntityStatus.failure,
            title: 'Failure',
            message: ErrorMessage('site').add,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: ErrorMessage('site').add,
        ));
      }
    }
  }

  Future<void> _onUpdateSitesEvent(
      UpdateSitesEvent event, Emitter<AddEditSiteState> emit) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await sitesRepository.updateSites(Sites(
          id: event.siteId,
          name: state.siteName,
          sanitizedName: state.siteName,
          siteCode: state.siteCode,
          sanitizedCode: state.siteCode,
          referenceCode: state.reference,
          active: true,
          jsaArchiveReview: state.jsaArchiveReviewStatus,
          jsaMethodId: state.selectedJsaMethod!.id,
          timeZoneId: state.selectedTimezone!.timeZoneId,
          regionId: state.selectedSubregionId,
        ));
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            title: 'Success',
            message: "Site updated successfully.",
          ));
        } else if (response.statusCode == 409) {
          emit(state.copyWith(
              message: response.message,
              title: 'Failure',
              status: EntityStatus.failure));
        } else {
          emit(state.copyWith(
            status: EntityStatus.failure,
            title: 'Failure',
            message: ErrorMessage('site').edit,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: ErrorMessage('site').edit,
        ));
      }
    }
  }

  bool _checkValidation(Emitter<AddEditSiteState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.siteName)) {
      emit(state.copyWith(siteNameValidationMessage: FormValidationMessage(fieldName: 'Site Name').requiredMessage));
      success = false;
    } else if (Validation.isNotCheckedMin(state.siteName)) {
      emit(state.copyWith( siteNameValidationMessage: AppStrings.minSiteNameError));
      success = false;
    }

    if (Validation.isEmpty(state.siteCode)) {
      emit(state.copyWith(siteCodeValidationMessage:FormValidationMessage(fieldName: 'Site Code').requiredMessage));
      success = false;
    } else if (Validation.isNotCheckedMin(state.siteCode)) {
      emit(state.copyWith(siteCodeValidationMessage: AppStrings.minSiteCodeError));
      success = false;
    }
    if (Validation.isEmpty(state.reference)) {
      emit(state.copyWith(siteReferenceValidationMessage:FormValidationMessage(fieldName: 'Site Reference').requiredMessage));
      success = false;
    } else if (Validation.isNotCheckedMin(state.reference)) {
      emit(state.copyWith(siteReferenceValidationMessage: AppStrings.minReferenceError));
      success = false;
    }
    else if (Validation.isNumberonly(state.reference)) {
      emit(state.copyWith(siteReferenceValidationMessage: FormValidationMessage(fieldName: 'Site Reference').numberMessage));
      success = false;
    }

    if (state.selectedJsaMethod == null) {
      emit(state.copyWith( jsaMethodValidationMessage:   FormValidationMessage(fieldName: 'JSA Method').requiredMessage));
      success = false;
    }

    if (state.selectedTimezone == null) {
      emit(state.copyWith( timezoneValidationMessage:FormValidationMessage(fieldName: 'Time zone').requiredMessage));
      success = false;
    }

    if (state.selectedSubregion == '') {
      emit(state.copyWith(regionValidationMessage:FormValidationMessage(fieldName: 'Region').requiredMessage));
      success = false;
    }
    return success;
  }
}
