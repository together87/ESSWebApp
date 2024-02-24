import 'dart:convert';

class TimeZoneCreate {
  int? id;
  int? timeZoneId;
  int? regionId;

  //String? regionName;
  // String? timeZoneName;

  TimeZoneCreate({
    this.id = 0,
    this.timeZoneId = 0,
    required this.regionId,
    /*required this.regionName,
      required this.timeZoneName*/
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'timeZoneId': timeZoneId,
      'regionId': regionId,
      // 'regionName': regionName,
      //'timeZoneName': timeZoneName
    };
    return map;
  }

  factory TimeZoneCreate.fromMap(Map<String, dynamic> map) {
    return TimeZoneCreate(
      id: map['id'] as int,
      timeZoneId: map['timeZoneId'] as int,
      regionId: map['regionId'] as int,
      /* regionName:
          map['regionName'] != null ? map['regionName'] as String : null,
      timeZoneName: map['timeZoneName'] ?? '',*/
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeZoneCreate.fromJson(String source) => TimeZoneCreate.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool? get stringify => throw UnimplementedError();

  TimeZoneCreate copyWith({
    int? id,
    int? timeZoneId,
    int? regionId,
    String? regionName,
    String? timeZoneName,
  }) {
    return TimeZoneCreate(
      id: id ?? this.id,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      regionId: regionId ?? this.regionId,
      /*  regionName: regionName ?? this.regionName,
      timeZoneName: timeZoneName ?? this.timeZoneName,*/
    );
  }
}
