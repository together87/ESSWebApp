part of 'project_details_bloc.dart';

abstract class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();

  @override
  List<Object?> get props => [];
}

/// event to load the project detail
class ProjectDetailsLoaded extends ProjectDetailsEvent {}

/// event to load the companies list
class ProjectDetailsCompaniesListLoaded extends ProjectDetailsEvent {}

/// event to load the companies view Change
class ProjectDetailsCompaniesViewChanged extends ProjectDetailsEvent {
  final String view;
  const ProjectDetailsCompaniesViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}

/// event to load the supporting document list
class ProjectDetailsSupportingDocumentListLoaded extends ProjectDetailsEvent {}

/// event to load the supporting document change
class ProjectSupportingDocumentChanged extends ProjectDetailsEvent {
  final PlatformFile imageList;
  const ProjectSupportingDocumentChanged({required this.imageList});

  @override
  List<Object> get props => [imageList];
}

/// event to change short description
class ProjectSupportingDescriptionChanged extends ProjectDetailsEvent {
  final String description;

  const ProjectSupportingDescriptionChanged({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

/// event to load the supporting document upload
class ProjectDetailsSupportingDocumentUpload extends ProjectDetailsEvent {}
