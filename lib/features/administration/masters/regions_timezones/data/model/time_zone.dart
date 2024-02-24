import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class TimeZone {
  final int? id;
  final int? timeZoneId;
  final int? subRegionId;
  final String? timeZoneName;
  final String? name;

  const TimeZone(
      {this.id,
      this.timeZoneId,
      this.subRegionId,
      this.timeZoneName,
      this.name});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'timeZoneName': timeZoneName,
      'name': name,
      'subRegionId': subRegionId,
      'timeZoneId': timeZoneId,
    };
  }

  factory TimeZone.fromMap(Map<String, dynamic> map) {
    return TimeZone(
      id: map['id'] as int,
      timeZoneName: map['timeZoneName'],
      subRegionId: map['subRegionId'] == null ? 0 : map['subRegionId'] as int,
      name: map['name'],
      timeZoneId: map['timeZoneId'] == null ? 0 : map['timeZoneId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeZone.fromJson(String source) => TimeZone.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool? get stringify => throw UnimplementedError();

  TimeZone copyWith({
    int? id,
    String? timeZoneName,
    String? name,
    int? subRegionId,
    int? timeZoneId,
  }) {
    return TimeZone(
      id: id ?? this.id,
      timeZoneName: timeZoneName ?? this.timeZoneName,
      name: name ?? this.name,
      subRegionId: subRegionId ?? this.subRegionId,
      timeZoneId: timeZoneId ?? this.timeZoneId,
    );
  }
}
