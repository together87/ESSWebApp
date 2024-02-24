part of 'project_list_bloc.dart';

class ProjectListState extends Equatable {
  final EntityStatus projectCrud;
  final EntityStatus status;
  final String message;
  final String title;

  /// loaded project list
  final List<Project> projectList;

  const ProjectListState({
    this.projectCrud = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.projectList = const [],
  });

  @override
  List<Object?> get props => [
        projectCrud,
        status,
        message,
        title,
        projectList,
      ];

  ProjectListState copyWith({
    EntityStatus? projectCrud,
    EntityStatus? status,
    String? message,
    String? title,
    List<Project>? projectList,
  }) {
    return ProjectListState(
      projectCrud: projectCrud ?? this.projectCrud,
      status: status ?? this.status,
      message: message ?? this.message,
      title: title ?? this.title,
      projectList: projectList ?? this.projectList,
    );
  }
}
