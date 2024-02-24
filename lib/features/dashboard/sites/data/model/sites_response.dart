// ignore_for_file: avoid_print

import '/common_libraries.dart';

class SitesResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<Sites>? dataList;
  Sites? data;
  SitesResponse({
    required this.isSuccess,
    required this.message,
    this.statusCode = 200,
    this.dataList,
    this.data,
  }) {
    message = message.replaceAll('"', '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
      'datalist': dataList,
      'data': data,
    };
  }

  String toJson() => json.encode(toMap());

  factory SitesResponse.fromJson(String source) => SitesResponse.fromMap(json.decode(source));

  factory SitesResponse.fromMap(Map<String, dynamic> map) {
    String message = (map['Message'] ?? (map['message'] ?? (map['Description'] ?? ''))).toString();
    message = message.replaceAll('"', '');
    return SitesResponse(
        statusCode: map['StatusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null ? (map['Message'] ?? (map['message'] ?? '')).toString().contains('success') : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != null ? (map['data'] != {} ? map['data'] : {}) : {},
        ).map((e) => Sites.fromMap(e)).toList());
  }

  factory SitesResponse.fromJson2(String source) => SitesResponse.fromMap2(json.decode(source));

  factory SitesResponse.fromMap2(Map<String, dynamic> map) {
    String message = (map['Message'] ?? (map['message'] ?? (map['Description'] ?? ''))).toString();
    message = message.replaceAll('"', '');
    return SitesResponse(
      statusCode: map['statusCode'] ?? 200,
      isSuccess: map['isSuccess'] == null ? (map['Message'] ?? (map['message'] ?? '')).toString().contains('success') : map['isSuccess'] as bool,
      message: message,
      data: Sites.fromMap(map['data'] != null ? map['data'] as Map<String, dynamic> : {"id": 0, "name": "null"}),
    );
  }

  factory SitesResponse.fromString(String map) {
    return SitesResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      dataList: null,
      data: null,
    );
  }
}

/*class Sites extends Entity {
  String? sanitizedName;
  String? siteCode;
  String? sanitizedCode;
  String? siteType;
  String? referenceCode;
  String? timeZoneName;
  String? regionName;
  int? regionId;
  int? timeZoneId;
  bool? jsaArchiveReview;
  bool? isDefault;
  int? jsaMethodId;
  String? jsaMethod;
  String? deactivatedBy;
  String? userId;

  Sites({
    super.id,
    super.name,
    super.deactivationDate,
    super.active,
    this.sanitizedName = '',
    this.siteCode,
    this.sanitizedCode,
    this.siteType,
    this.referenceCode,
    this.timeZoneName,
    this.regionName,
    this.regionId,
    this.timeZoneId,
    this.jsaArchiveReview,
    this.isDefault,
    this.jsaMethodId,
    this.jsaMethod,
    this.deactivatedBy,
    this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        deactivationDate,
        active,
        sanitizedName,
        siteCode,
        sanitizedCode,
        siteType,
        referenceCode,
        timeZoneName,
        regionName,
        regionId,
        timeZoneId,
        jsaArchiveReview,
        isDefault,
        jsaMethodId,
        jsaMethod,
        deactivatedBy,
        userId,
      ];

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sanitizedName': sanitizedName,
      'siteCode': siteCode,
      'sanitizedCode': sanitizedCode,
      'siteType': siteType,
      'referenceCode': referenceCode,
      'active': active,
      'jsaArchiveReview': jsaArchiveReview,
      'jsaMethodId': jsaMethodId,
    };
  }

  String toJson() => json.encode(toMap());

  factory Sites.fromJson(String source) => Sites.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory Sites.fromMap(Map<String, dynamic> map) {
    return Sites(
        id: map['id'].toString(),
        name: map['name'],
        sanitizedName: map['sanitizedName'],
        siteCode: map['siteCode'],
        sanitizedCode: map['sanitizedCode'],
        siteType: map['siteType'],
        referenceCode: map['referenceCode'],
        timeZoneName: map['timeZoneName'],
        regionName: map['regionName'],
        regionId: map['regionId'],
        timeZoneId: map['timeZoneId'],
        active: map['active'],
        jsaArchiveReview: map['jsaArchiveReview'],
        isDefault: map['default'],
        jsaMethodId: map['jsaMethodId'],
        jsaMethod: map['jsaMethod'],
        deactivatedBy: map['deactivatedBy'],
        deactivationDate: map['deactivationDate'],
        userId: map['userId']);
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Site': name,
      'Code': siteCode,
      'Region': regionName,
      'Timezone': timeZoneName,
      'Status': active,
      'Action': Icons.delete,
    };
  }

  @override
  bool? get stringify => throw UnimplementedError();

  Sites copyWith({String? sanitizedName, String? siteCode, String? sanitizedCode, String? siteType, String? referenceCode, String? timeZoneName, String? regionName, int? regionId, int? timeZoneId, bool? jsaArchiveReview, bool? isDefault, int? jsaMethodId, String? deactivatedBy, String? jsaMethod, String? userId}) {
    return Sites(
      id: id ?? id,
      name: name ?? name,
      active: active,
      deactivationDate: deactivationDate ?? deactivationDate,
      sanitizedName: sanitizedName ?? this.sanitizedName,
      siteCode: siteCode ?? this.siteCode,
      sanitizedCode: sanitizedCode ?? this.sanitizedCode,
      siteType: siteType ?? this.siteType,
      referenceCode: referenceCode ?? this.referenceCode,
      timeZoneName: timeZoneName ?? this.timeZoneName,
      regionName: regionName ?? this.regionName,
      regionId: regionId ?? this.regionId,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      jsaArchiveReview: jsaArchiveReview ?? this.jsaArchiveReview,
      isDefault: isDefault ?? this.isDefault,
      jsaMethodId: jsaMethodId ?? this.jsaMethodId,
      jsaMethod: jsaMethod ?? this.jsaMethod,
      deactivatedBy: deactivatedBy ?? this.deactivatedBy,
      userId: userId ?? this.userId,
    );
  }
}*/

enum PageStatus {
  initialPage,
  createPage,
  updatePage,
  deletePage,
  detailPage;

  bool get isInitialPage => this == PageStatus.initialPage;
  bool get isCreatePage => this == PageStatus.createPage;
  bool get isUpdatePage => this == PageStatus.updatePage;
  bool get isDeletePage => this == PageStatus.deletePage;
  bool get isDetailPage => this == PageStatus.detailPage;
}
