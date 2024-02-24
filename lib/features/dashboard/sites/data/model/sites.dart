import '/common_libraries.dart';

class SitesData {
  SitesData({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Sites data;

  factory SitesData.fromMap(Map<String, dynamic> map) {
    return SitesData(
      data: Sites.fromMap(map['data']),
      message: map['message'],
    );
  }

  factory SitesData.fromJson(String source) => SitesData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Sites extends Entity {
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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'sanitizedName': sanitizedName,
      'siteCode': siteCode,
      'sanitizedCode': sanitizedCode,
      'referenceCode': referenceCode,
      'active': active,
      'jsaArchiveReview': jsaArchiveReview,
      'jsaMethodId': jsaMethodId,
      'regionId': regionId,
      'timeZoneId': timeZoneId,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
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

  Sites copyWith({
    String? sanitizedName,
    String? siteCode,
    String? sanitizedCode,
    String? siteType,
    String? referenceCode,
    String? timeZoneName,
    String? regionName,
    int? regionId,
    int? timeZoneId,
    bool? jsaArchiveReview,
    bool? isDefault,
    int? jsaMethodId,
    String? deactivatedBy,
    String? jsaMethod,
    String? userId,
  }) {
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
}
