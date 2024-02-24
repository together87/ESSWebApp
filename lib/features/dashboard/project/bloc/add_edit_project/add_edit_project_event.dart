part of 'add_edit_project_bloc.dart';

abstract class AddEditProjectEvent extends Equatable {
  const AddEditProjectEvent();

  @override
  List<Object?> get props => [];
}

class AddEditProjectLoaded extends AddEditProjectEvent {
  final String projectId;
  const AddEditProjectLoaded({required this.projectId});
  @override
  List<Object> get props => [projectId];
}

class AddEditProjectSiteListLoaded extends AddEditProjectEvent {}

class AddEditProjectDirectorListLoaded extends AddEditProjectEvent {
  final String type;
  const AddEditProjectDirectorListLoaded({required this.type});

  @override
  List<Object> get props => [type];
}

class AddEditProjectNameChanged extends AddEditProjectEvent {
  final String name;
  const AddEditProjectNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class AddEditProjectNumberChanged extends AddEditProjectEvent {
  final String number;
  const AddEditProjectNumberChanged({required this.number});

  @override
  List<Object> get props => [number];
}

class AddEditProjectReferenceChanged extends AddEditProjectEvent {
  final String projectReference;
  const AddEditProjectReferenceChanged({required this.projectReference});

  @override
  List<Object> get props => [projectReference];
}

class AddEditProjectActiveStatusChanged extends AddEditProjectEvent {
  final bool activeStatus;
  const AddEditProjectActiveStatusChanged({required this.activeStatus});

  @override
  List<Object> get props => [activeStatus];
}

class AddEditProjectKPIStatusChanged extends AddEditProjectEvent {
  final bool kpiStatus;
  const AddEditProjectKPIStatusChanged({required this.kpiStatus});

  @override
  List<Object> get props => [kpiStatus];
}

class AddEditProjectPeerReviewRequiredStatusStatusChanged extends AddEditProjectEvent {
  final bool peerReviewRequiredStatus;
  const AddEditProjectPeerReviewRequiredStatusStatusChanged({required this.peerReviewRequiredStatus});

  @override
  List<Object> get props => [peerReviewRequiredStatus];
}

class AddEditProjectItemSiteChanged extends AddEditProjectEvent {
  final Site site;
  const AddEditProjectItemSiteChanged({required this.site});

  @override
  List<Object> get props => [site];
}

class AddEditProjectItemDirectorChanged extends AddEditProjectEvent {
  final Director director;
  const AddEditProjectItemDirectorChanged({required this.director});

  @override
  List<Object> get props => [director];
}

/// event to add project
class AddEditProjectAdded extends AddEditProjectEvent {}

/// event to edit project
class AddEditProjectEdited extends AddEditProjectEvent {
  final String id;
  const AddEditProjectEdited({required this.id});

  @override
  List<Object> get props => [id];
}
