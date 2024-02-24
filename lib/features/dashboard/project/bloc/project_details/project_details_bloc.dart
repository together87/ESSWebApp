import 'package:file_picker/file_picker.dart';

import '/common_libraries.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';

class ProjectDetailsBloc extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final BuildContext context;
  late ProjectRepository projectRepository;
  final String projectId;
  ProjectDetailsBloc(
    this.context,
    this.projectId,
  ) : super(const ProjectDetailsState()) {
    projectRepository = RepositoryProvider.of(context);

    on<ProjectDetailsLoaded>(_onProjectDetailsLoaded);
    on<ProjectDetailsCompaniesViewChanged>(_onProjectDetailsCompaniesViewChanged);
    on<ProjectDetailsCompaniesListLoaded>(_onProjectDetailsCompaniesListLoaded);
    on<ProjectDetailsSupportingDocumentListLoaded>(_onProjectDetailsSupportingDocumentListLoaded);
    on<ProjectSupportingDocumentChanged>(_onProjectSupportingDocumentChanged);
    on<ProjectSupportingDescriptionChanged>(_onProjectSupportingDescriptionChanged);
    on<ProjectDetailsSupportingDocumentUpload>(_onProjectDetailsSupportingDocumentUpload);
  }

  Future<void> _onProjectDetailsLoaded(
    ProjectDetailsLoaded event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(detailsLoader: EntityStatus.loading));
      Project project = await projectRepository.getProjectById(projectId);
      emit(
        state.copyWith(project: Nullable.value(project), detailsLoader: EntityStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(detailsLoader: EntityStatus.failure),
      );
    }
  }

  Future<void> _onProjectDetailsCompaniesListLoaded(
    ProjectDetailsCompaniesListLoaded event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        companiesList: ['Power Tools & Roofing LLC', 'Galelio Weather Services Inc', 'Georgia Concrete', 'Kashi Inc', 'Logistic and Manpower Placements LLc', 'Maxwell And Gartner Inc', 'Runkin Associates Glassworks Inc', 'Zodiac Builders Inc'],
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onProjectDetailsCompaniesViewChanged(
    ProjectDetailsCompaniesViewChanged event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        view: event.view,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }

  Future<void> _onProjectDetailsSupportingDocumentListLoaded(
    ProjectDetailsSupportingDocumentListLoaded event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(state.copyWith(documentListStatus: EntityStatus.loading));

    try {
      List<Document> documentList = await projectRepository.getDocumentListForDetail("");

      emit(state.copyWith(
        documentListStatus: EntityStatus.success,
        documentList: documentList,
      ));
    } catch (e) {
      emit(state.copyWith(documentListStatus: EntityStatus.failure));
    }
  }

  void _onProjectSupportingDocumentChanged(
    ProjectSupportingDocumentChanged event,
    Emitter<ProjectDetailsState> emit,
  ) {
    emit(state.copyWith(imageList: event.imageList));
  }

  void _onProjectSupportingDescriptionChanged(
    ProjectSupportingDescriptionChanged event,
    Emitter<ProjectDetailsState> emit,
  ) {
    emit(state.copyWith(
      shortDesText: event.description,
    ));
  }

  void _onProjectDetailsSupportingDocumentUpload(
    ProjectDetailsSupportingDocumentUpload event,
    Emitter<ProjectDetailsState> emit,
  ) {
    if (state.imageList == null) {
      emit(state.copyWith(status: EntityStatus.failure, message: 'Document file required', title: 'Info'));
    } else if (Validation.isEmpty(state.shortDesText)) {
      emit(state.copyWith(status: EntityStatus.failure, message: 'Short description required', title: 'Info'));
    } else {
      emit(state.copyWith(
        status: EntityStatus.loading,
      ));

      try {
        Document document = Document(
          shortDescription: state.shortDesText,
          id: 1,
          fileName: state.imageList?.name,
          upload: "Josh Peyton on 12/3/2020",
          uri: '',
        );

        List<Document>? documentList = List.from(state.documentList);
        documentList.add(document);

        emit(state.copyWith(documentList: documentList, status: EntityStatus.success, message: 'Document uploaded successfully', title: 'Success', shortDesText: '', imageList: null));
      } catch (e) {
        emit(state.copyWith(status: EntityStatus.failure, message: 'Document uploaded fail', title: 'Fail'));
      }
    }
  }
}
