part of 'project_list_bloc.dart';

abstract class ProjectListEvents extends Equatable {
  const ProjectListEvents();

  @override
  List<Object?> get props => [];
}

class ProjectListFiltered extends ProjectListEvents {
  const ProjectListFiltered();

  @override
  List<Object?> get props => [];
}

class ProjectDelete extends ProjectListEvents {
  final String projectId;
  const ProjectDelete({required this.projectId});

  @override
  List<Object> get props => [projectId];
}
