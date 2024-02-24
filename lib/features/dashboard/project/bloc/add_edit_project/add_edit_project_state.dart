part of 'add_edit_project_bloc.dart';

class AddEditProjectState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoaded;
  final String message;
  final String title;

  /// site list
  final List<Site> siteList;

  /// site to create project
  final Site? site;

  /// site director
  final List<Director> directorList;

  /// site to create project
  final Director? director;

  ///project name
  final String name;
  final String nameValidationMessage;

  ///project number
  final String number;
  final String numberValidationMessage;

  ///project reference
  final String projectReference;
  final String referenceValidationMessage;

  ///project active status
  final bool activeStatus;

  ///project kpi status
  final bool kpiStatus;

  ///project Peer Review Required status
  final bool peerReviewRequiredStatus;

  final String siteValidationMessage;
  final String directorValidationMessage;

  const AddEditProjectState({
    this.status = EntityStatus.initial,
    this.detailsLoaded = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.name = '',
    this.number = '',
    this.nameValidationMessage = '',
    this.numberValidationMessage = '',
    this.siteValidationMessage = '',
    this.directorValidationMessage = '',
    this.projectReference = '',
    this.referenceValidationMessage = '',
    this.siteList = const [],
    this.directorList = const [],
    this.site,
    this.director,
    this.activeStatus = false,
    this.kpiStatus = false,
    this.peerReviewRequiredStatus = false,
  });

  @override
  List<Object?> get props => [
        status,
        detailsLoaded,
        message,
        title,
        siteList,
        site,
        director,
        directorList,
        nameValidationMessage,
        numberValidationMessage,
        siteValidationMessage,
        directorValidationMessage,
        projectReference,
        referenceValidationMessage,
        number,
        name,
        activeStatus,
        kpiStatus,
        peerReviewRequiredStatus,
      ];

  AddEditProjectState copyWith({
    EntityStatus? status,
    EntityStatus? detailsLoaded,
    String? message,
    String? title,
    String? name,
    String? nameValidationMessage,
    String? number,
    String? numberValidationMessage,
    String? referenceValidationMessage,
    String? siteValidationMessage,
    String? directorValidationMessage,
    String? projectReference,
    bool? activeStatus,
    bool? kpiStatus,
    bool? peerReviewRequiredStatus,
    List<Site>? siteList,
    Nullable<Site?>? site,
    List<Director>? directorList,
    Nullable<Director?>? director,
  }) {
    return AddEditProjectState(
      status: status ?? this.status,
      detailsLoaded: detailsLoaded ?? this.detailsLoaded,
      message: message ?? this.message,
      title: title ?? this.title,
      siteList: siteList ?? this.siteList,
      site: site != null ? site.value : this.site,
      director: director != null ? director.value : this.director,
      directorList: directorList ?? this.directorList,
      name: name ?? this.name,
      nameValidationMessage:
          nameValidationMessage ?? this.nameValidationMessage,
      number: number ?? this.number,
      numberValidationMessage:
          numberValidationMessage ?? this.numberValidationMessage,
      projectReference: projectReference ?? this.projectReference,
      siteValidationMessage:
          siteValidationMessage ?? this.siteValidationMessage,
      referenceValidationMessage:
          referenceValidationMessage ?? this.referenceValidationMessage,
      directorValidationMessage:
          directorValidationMessage ?? this.directorValidationMessage,
      activeStatus: activeStatus ?? this.activeStatus,
      kpiStatus: kpiStatus ?? this.kpiStatus,
      peerReviewRequiredStatus:
          peerReviewRequiredStatus ?? this.peerReviewRequiredStatus,
    );
  }
}
