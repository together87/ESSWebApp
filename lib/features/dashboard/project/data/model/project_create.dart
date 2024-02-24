import '../../../../../common_libraries.dart';

class ProjectCreate extends Equatable {
  final String? id;
  final String name;
  final String projectNumber;
  final String referenceNumber;
  final int siteId;
  final String siteName;
  final int directorId;
  final String directorName;
  final bool kpi;
  final bool peerReviewRequired;
  final bool active;
  final int deactivatedBy;

  const ProjectCreate({
    this.id,
    this.name = '',
    this.siteId = 0,
    this.referenceNumber = '',
    this.projectNumber = '',
    this.siteName = '',
    this.directorId = 0,
    this.directorName = '',
    this.kpi = false,
    this.peerReviewRequired = false,
    this.active = false,
    this.deactivatedBy = 1,
  });

  @override
  List<Object?> get props => [
        siteId,
        referenceNumber,
        projectNumber,
        siteName,
        directorId,
        directorName,
        kpi,
        peerReviewRequired,
        active,
        deactivatedBy,
        directorName,
        referenceNumber,
      ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'siteId': siteId,
      'referenceNumber': referenceNumber,
      'projectNumber': projectNumber,
      'deactivationDate': (DateTime.now()).toIso8601String(),
      'siteName': siteName,
      'directorId': directorId,
      'directorName': directorName,
      'kpi': kpi,
      'peerReviewRequired': peerReviewRequired,
      'active': active,
      'deactivatedBy': deactivatedBy,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  String toJson() => json.encode(toMap());

  ProjectCreate copyWith({
    String? id,
    String? name,
    String? siteName,
    int? siteId,
    String? referenceNumber,
    String? projectNumber,
    DateTime? startDate,
    DateTime? estimatedEndDate,
    int? directorId,
    String? directorName,
    bool? kpi,
    bool? peerReviewRequired,
    bool? active,
    int? deactivatedBy,
  }) {
    return ProjectCreate(
      id: id ?? this.id,
      name: name ?? this.name,
      siteId: siteId ?? this.siteId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      projectNumber: projectNumber ?? this.projectNumber,
      siteName: siteName ?? this.siteName,
      directorId: directorId ?? this.directorId,
      directorName: directorName ?? this.directorName,
      kpi: kpi ?? this.kpi,
      peerReviewRequired: peerReviewRequired ?? this.peerReviewRequired,
      active: active ?? this.active,
      deactivatedBy: deactivatedBy ?? this.deactivatedBy,
    );
  }
}
