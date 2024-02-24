import '/common_libraries.dart';

class ProjectData {
  ProjectData({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Project data;

  factory ProjectData.fromMap(Map<String, dynamic> map) {
    return ProjectData(
      data: Project.fromMap(map['data']),
      message: map['message'],
    );
  }

  factory ProjectData.fromJson(String source) => ProjectData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Project extends Entity {
  final String projectName;
  final String siteName;
  final int siteId;
  final int directorId;
  final String directorName;
  final String? proNumber;
  final String projectReference;
  final bool? kpi;
  final bool? peerReviewRequired;

  const Project({
    super.id,
    super.active,
    this.projectName = '',
    this.siteName = '',
    this.siteId = 0,
    this.directorId = 0,
    this.directorName = '',
    this.proNumber,
    this.projectReference = '',
    this.peerReviewRequired = false,
    this.kpi = false,
  });

  @override
  List<Object?> get props => [
        id,
        projectName,
        siteId,
        siteName,
        directorId,
        directorName,
        proNumber,
        projectReference,
        peerReviewRequired,
        kpi,
      ];

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      projectName: map['name'] ?? '',
      siteId: map['siteId'] ?? 0,
      siteName: map['siteName'] ?? '',
      directorName: map['directorName'] ?? '',
      directorId: map['directorId'] ?? 0,
      proNumber: map['projectNumber'] ?? '',
      projectReference: map['referenceNumber'] ?? '',
      peerReviewRequired: map['peerReviewRequired'] ?? false,
      kpi: map['kpi'] ?? false,
      active: map['active'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'projectName': projectName,
      'siteName': siteName,
      'status': active,
      'director': directorName,
      'proNumber': proNumber,
      'projectReference': projectReference,
    };
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Number': id,
      'Status': active,
      'Name': projectName,
      'Site': siteName,
      'Director': directorName,
      'Action': Icons.delete,
    };
  }

  Project copyWith({
    String? projectName,
    int? siteId,
    String? siteName,
    int? directorId,
    String? directorName,
    String? proNumber,
    String? projectReference,
  }) {
    return Project(
      projectName: projectName ?? this.projectName,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      directorId: directorId ?? this.directorId,
      directorName: directorName ?? this.directorName,
      proNumber: proNumber ?? this.proNumber,
      projectReference: projectReference ?? this.projectReference,
    );
  }
}
