import '/common_libraries.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvents, ProjectListState> {
  final BuildContext context;
  late ProjectRepository projectRepository;

  ProjectListBloc(this.context) : super(const ProjectListState()) {
    projectRepository = RepositoryProvider.of(context);

    on<ProjectListFiltered>(_onProjectListFiltered);
    on<ProjectDelete>(_onProjectDelete);
  }

  Future<void> _onProjectListFiltered(
    ProjectListFiltered event,
    Emitter<ProjectListState> emit,
  ) async {
    emit(state.copyWith(projectCrud: EntityStatus.loading));
    try {
      List<Project> projectList = await projectRepository.getFilteredProjectList();

      emit(state.copyWith(
        projectList: projectList,
        projectCrud: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(projectCrud: EntityStatus.failure, message: "Failed to get project list"));
    }
  }

  Future<void> _onProjectDelete(
    ProjectDelete event,
    Emitter<ProjectListState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));
    try {
      EntityResponse response = await projectRepository.deleteProject(event.projectId);
      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          title: 'Success',
          message: "Project deleted successfully.",
        ));
        add(ProjectListFiltered());
      } else {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        title: 'Failure',
        message: ErrorMessage('project').delete,
      ));
    }
  }
}
