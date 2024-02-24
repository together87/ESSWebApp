// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'dart:convert';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

class ObservationTypeResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<ObservationType>? dataList;
  ObservationType? data;
  ObservationTypeResponse({
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

  factory ObservationTypeResponse.fromJson(String source) =>
      ObservationTypeResponse.fromMap(json.decode(source));

  factory ObservationTypeResponse.  fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return ObservationTypeResponse(
        statusCode: map['StatusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != null ? ( map['data'] != {} ? map['data'] : {}) : {},
        ).map((e) => ObservationType.fromMap(e)).toList());
  }

  factory ObservationTypeResponse.fromJson2(String source) =>
      ObservationTypeResponse.fromMap2(json.decode(source));

  factory ObservationTypeResponse.fromMap2(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return ObservationTypeResponse(
      statusCode: map['StatusCode'] ?? 200,
      isSuccess: map['isSuccess'] == null
          ? (map['Message'] ?? (map['message'] ?? ''))
              .toString()
              .contains('success')
          : map['isSuccess'] as bool,
      message: message,
      data: ObservationType.fromMap(map['data'] != null
          ? map['data'] as Map<String, dynamic>
          : {"id": 0, "name": "null"}),
    );
  }
  
  factory ObservationTypeResponse.fromString(String map) {
    return ObservationTypeResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      dataList: null,
      data: null,
    );
  }
}

class ObservationType extends Equatable {
  int? id;
  String? name;
  int? severityLevelId;
  int? visibilityTypeId;
  String? severityLevel;
  String? visibilityType;

  ObservationType(
      {this.id,
      this.name,
      this.severityLevelId,
      this.visibilityTypeId,
      this.severityLevel,
      this.visibilityType});

  @override
  List<Object?> get props => [
        id,
        name,
        severityLevelId,
        visibilityTypeId,
        severityLevel,
        visibilityType
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toString(),
      'severityLevelId': severityLevelId,
      'visibilityTypeId': visibilityTypeId,
    };
  }

  String toJson() => json.encode(toMap());

  factory ObservationType.fromJson(String source) => ObservationType.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory ObservationType.fromMap(Map<String, dynamic> map) {
    return ObservationType(
      id: map['id'] as int,
      name: map['name'],
      severityLevelId: map['severityLevelId'] as int,
      visibilityTypeId: map['visibilityTypeId'],
      severityLevel: map['severityLevel'],
      visibilityType: map['visibilityType'],
    );
  }

  @override
  bool? get stringify => throw UnimplementedError();

  ObservationType copyWith({
    int? id,
    String? name,
    int? severityLevelId,
    int? visibilityTypeId,
    String? severityLevel,
    String? visibilityType,
  }) {
    return ObservationType(
      id: id ?? this.id,
      name: name ?? this.name,
      severityLevelId: severityLevelId ?? this.severityLevelId,
      visibilityTypeId: visibilityTypeId ?? this.visibilityTypeId,
      severityLevel: severityLevel ?? this.severityLevel,
      visibilityType: visibilityType ?? this.visibilityType,
    );
  }
}
