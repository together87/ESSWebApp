part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoader;
  final EntityStatus documentListStatus;
  final String message;
  final String title;
  final String shortDesText;
  final Project? project;

  final List<String> companiesList;
  final List<Document> documentList;
  final PlatformFile? imageList;

  ///1=Companies List View
  ///2=Associated Available Companies View
  final String view;

  const ProjectDetailsState({
    this.documentList = const [],
    this.detailsLoader = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.documentListStatus = EntityStatus.initial,
    this.message = '',
    this.shortDesText = '',
    this.title = '',
    this.project,
    this.imageList,
    this.view = "1",
    this.companiesList = const [],
  });

  @override
  List<Object?> get props => [
        status,
        detailsLoader,
        documentListStatus,
        message,
        shortDesText,
        title,
        project,
        view,
        companiesList,
        documentList,
        imageList,
      ];

  ProjectDetailsState copyWith({
    EntityStatus? status,
    EntityStatus? detailsLoader,
    EntityStatus? documentListStatus,
    String? message,
    String? shortDesText,
    String? title,
    Nullable<Project?>? project,
    String? view,
    List<String>? companiesList,
    List<Document>? documentList,
    PlatformFile? imageList,
  }) {
    return ProjectDetailsState(
      status: status ?? this.status,
      detailsLoader: detailsLoader ?? this.detailsLoader,
      documentListStatus: documentListStatus ?? this.documentListStatus,
      message: message ?? this.message,
      shortDesText: shortDesText ?? this.shortDesText,
      title: title ?? this.title,
      project: project != null ? project.value : this.project,
      view: view ?? this.view,
      companiesList: companiesList ?? this.companiesList,
      documentList: documentList ?? this.documentList,
      imageList: imageList ?? this.imageList,
    );
  }
}
