import 'package:ecosys_safety/features/dashboard/sites/data/repository/sites_repository.dart';

import '/common_libraries.dart';

part 'add_edit_project_event.dart';
part 'add_edit_project_state.dart';

class AddEditProjectBloc extends Bloc<AddEditProjectEvent, AddEditProjectState> {
  final BuildContext context;
  late ProjectRepository projectRepository;
  late SitesRepository sitesRepository;
  late UsersRepository usersRepository;

  AddEditProjectBloc(this.context) : super(const AddEditProjectState()) {
    projectRepository = context.read();
    sitesRepository = context.read();
    usersRepository = context.read();

    on<AddEditProjectLoaded>(_onAddEditProjectLoaded);
    on<AddEditProjectSiteListLoaded>(_onAddEditProjectSiteListLoaded);
    on<AddEditProjectItemSiteChanged>(_onAddEditProjectItemSiteChanged);
    on<AddEditProjectDirectorListLoaded>(_onAddEditProjectDirectorListLoaded);
    on<AddEditProjectItemDirectorChanged>(_onAddEditProjectItemDirectorChanged);
    on<AddEditProjectNumberChanged>(_onAddEditProjectNumberChanged);
    on<AddEditProjectNameChanged>(_onAddEditProjectNameChanged);
    on<AddEditProjectReferenceChanged>(_onAddEditProjectReferenceChanged);
    on<AddEditProjectActiveStatusChanged>(_onAddEditProjectActiveStatusChanged);
    on<AddEditProjectKPIStatusChanged>(_onAddEditProjectKPIStatusChanged);
    on<AddEditProjectPeerReviewRequiredStatusStatusChanged>(_onAddEditProjectPeerReviewRequiredStatusStatusChanged);
    on<AddEditProjectAdded>(_onAddEditProjectAdded);
    on<AddEditProjectEdited>(_onAddEditProjectEdited);
  }

  Future<void> _onAddEditProjectLoaded(
    AddEditProjectLoaded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    emit(state.copyWith(detailsLoaded: EntityStatus.loading));

    try {
      Project project = await projectRepository.getProjectById(event.projectId);
      emit(state.copyWith(
        number: project.proNumber.toString(),
        projectReference: project.projectReference,
        name: project.projectName,
        site: Nullable.value(Site(
          id: project.siteId,
          name: project.siteName,
        )),
        director: Nullable.value(Director(
          id: project.directorId,
          name: project.directorName,
        )),
        activeStatus: project.active,
        kpiStatus: project.kpi,
        peerReviewRequiredStatus: project.peerReviewRequired,
        detailsLoaded: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(detailsLoaded: EntityStatus.failure, message: "Failed to get project details"));
    }
  }

  void _onAddEditProjectNameChanged(
    AddEditProjectNameChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      nameValidationMessage: '',
    ));
  }

  void _onAddEditProjectNumberChanged(
    AddEditProjectNumberChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      number: event.number,
      numberValidationMessage: '',
    ));
  }

  void _onAddEditProjectReferenceChanged(
    AddEditProjectReferenceChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      projectReference: event.projectReference,
      referenceValidationMessage: '',
    ));
  }

  void _onAddEditProjectActiveStatusChanged(
    AddEditProjectActiveStatusChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      activeStatus: event.activeStatus,
    ));
  }

  void _onAddEditProjectKPIStatusChanged(
    AddEditProjectKPIStatusChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      kpiStatus: event.kpiStatus,
    ));
  }

  void _onAddEditProjectPeerReviewRequiredStatusStatusChanged(
    AddEditProjectPeerReviewRequiredStatusStatusChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      peerReviewRequiredStatus: event.peerReviewRequiredStatus,
    ));
  }

  Future<void> _onAddEditProjectSiteListLoaded(
    AddEditProjectSiteListLoaded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    emit(state.copyWith(detailsLoaded: EntityStatus.loading));
    try {
      List<Site> siteList = await sitesRepository.getSiteListForProject();

      emit(
        state.copyWith(siteList: siteList, detailsLoaded: EntityStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(
        message: '',
        detailsLoaded: EntityStatus.failure,
      ));
    }
  }

  void _onAddEditProjectItemSiteChanged(
    AddEditProjectItemSiteChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      site: Nullable.value(event.site),
      siteValidationMessage: '',
    ));
  }

  Future<void> _onAddEditProjectDirectorListLoaded(
    AddEditProjectDirectorListLoaded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    try {
      List<Director> directorList = await usersRepository.getUserRoleByRoleList(event.type);

      emit(state.copyWith(directorList: directorList));
    } catch (e) {
      emit(state.copyWith(
        message: '',
      ));
    }
  }

  void _onAddEditProjectItemDirectorChanged(
    AddEditProjectItemDirectorChanged event,
    Emitter<AddEditProjectState> emit,
  ) {
    emit(state.copyWith(
      director: Nullable.value(event.director),
      directorValidationMessage: '',
    ));
  }

  Future<void> _onAddEditProjectAdded(
    AddEditProjectAdded event,
    Emitter<AddEditProjectState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await projectRepository.addProject(
          ProjectCreate(
            name: state.name,
            siteId: state.site!.id!,
            referenceNumber: state.projectReference,
            active: state.activeStatus,
            kpi: state.kpiStatus,
            peerReviewRequired: state.peerReviewRequiredStatus,
            directorId: state.director!.id,
            projectNumber: state.number,
            siteName: state.site!.name.toString(),
            directorName: state.director!.name.toString(),
          ),
        );
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            title: 'Success',
            message: "Project added successfully.",
          ));
        } else if (response.statusCode == 409) {
          emit(state.copyWith(message: response.message, title: 'Failure', status: EntityStatus.failure));
        } else {
          emit(state.copyWith(
            status: EntityStatus.failure,
            title: 'Failure',
            message: ErrorMessage('project').add,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: ErrorMessage('project').add,
        ));
      }
    }
  }

  Future<void> _onAddEditProjectEdited(
    AddEditProjectEdited event,
    Emitter<AddEditProjectState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await projectRepository.editProject(
          ProjectCreate(
            id: event.id,
            name: state.name,
            siteId: state.site!.id!,
            referenceNumber: state.projectReference,
            active: state.activeStatus,
            kpi: state.kpiStatus,
            peerReviewRequired: state.peerReviewRequiredStatus,
            directorId: state.director!.id,
            projectNumber: state.number,
            siteName: state.site!.name.toString(),
            directorName: state.director!.name.toString(),
          ),
        );
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            title: 'Success',
            message: "Project updated successfully.",
          ));
        } else if (response.statusCode == 409) {
          emit(state.copyWith(message: response.message, title: 'Failure', status: EntityStatus.failure));
        } else {
          emit(state.copyWith(
            status: EntityStatus.failure,
            title: 'Failure',
            message: ErrorMessage('project').edit,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: ErrorMessage('project').edit,
        ));
      }
    }
  }

  bool _checkValidation(Emitter<AddEditProjectState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.name)) {
      emit(state.copyWith(nameValidationMessage: FormValidationMessage(fieldName: 'Project Name').requiredMessage));
      success = false;
    } else if (state.name.length < 3) {
      emit(state.copyWith(nameValidationMessage: AppStrings.minProjectTypeError));
      success = false;
    } else if (state.name.length > 50) {
      emit(state.copyWith(nameValidationMessage: AppStrings.maxProjectTypeError));
      success = false;
    }

    if (Validation.isEmpty(state.number)) {
      emit(state.copyWith(numberValidationMessage: FormValidationMessage(fieldName: 'Project Number').requiredMessage));
      success = false;
    } else if (state.number.length < 3) {
      emit(state.copyWith(numberValidationMessage: AppStrings.projectNumberHint));
      success = false;
    }
    else if (Validation.isNumberonly(state.number)){
      emit(state.copyWith(numberValidationMessage: FormValidationMessage(fieldName: 'Project Number').numberMessage));
      success = false;
    }

    if (Validation.isEmpty(state.projectReference)) {
      emit(state.copyWith(referenceValidationMessage: FormValidationMessage(fieldName: 'Project Number').requiredMessage));
      success = false;
    } else if (state.projectReference.length < 3) {
      emit(state.copyWith(referenceValidationMessage: AppStrings.projectNumberHint));
      success = false;
    }
    else if (Validation.isNumberonly(state.projectReference)){
      emit(state.copyWith(referenceValidationMessage: FormValidationMessage(fieldName: 'Project Number').numberMessage));
      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(siteValidationMessage: FormValidationMessage(fieldName: 'Site').requiredMessage));
      success = false;
    }

    if (state.director == null) {
      emit(state.copyWith(directorValidationMessage: FormValidationMessage(fieldName: 'Director').requiredMessage));
      success = false;
    }
    return success;
  }
}
