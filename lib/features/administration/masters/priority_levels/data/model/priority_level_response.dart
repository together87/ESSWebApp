// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';

import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

class PriorityLevelResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<PriorityLevel>? dataList;

  PriorityLevelResponse({
    required this.isSuccess,
    required this.message,
    this.statusCode = 200,
    this.dataList,
  }) {
    message = message.replaceAll('"', '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
      'data': dataList,
    };
  }

  String toJson() => json.encode(toMap());

  factory PriorityLevelResponse.fromJson(String source) =>
      PriorityLevelResponse.fromMap(json.decode(source));

  factory PriorityLevelResponse.fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return PriorityLevelResponse(
        statusCode: map['StatusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != {} ? map['data'] : {},
        ).map((e) => PriorityLevel.fromMap(e)).toList());
  }

  factory PriorityLevelResponse.fromString(String map) {
    return PriorityLevelResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      dataList: null,
    );
  }
}

class PriorityLevel extends Equatable {
  int? id;
  String? name;
  int? priorityTypeId;
  String? color;
  String? priorityTypeName;
  PriorityType? priorityType;

  PriorityLevel(
      {this.id, this.name, this.priorityTypeId,this.priorityTypeName, this.priorityType, this.color});

  @override
  List<Object?> get props => [id, name, priorityTypeId,priorityTypeName, color, priorityType];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toString(),
      'priorityTypeId': priorityTypeId,
      'priorityTypeName':priorityTypeName,
      'color': color.toString(),
    };
  }

  factory PriorityLevel.fromMap(Map<String, dynamic> map) {
    return PriorityLevel(
      id: map['id'] as int,
      name: map['name'],
      priorityTypeId: map['priorityTypeId'] as int,
      priorityTypeName:map['priorityTypeName'],
      color: map['color'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PriorityLevel.fromJson(String source) => PriorityLevel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  @override
  bool? get stringify => throw UnimplementedError();

  PriorityLevel copyWith({
    int? id,
    String? name,
    int? priorityTypeId,
    String? priorityTypeName,
    PriorityType? priorityType,
    String? color,
  }) {
    return PriorityLevel(
      id: id ?? this.id,
      name: name ?? this.name,
      priorityTypeId: priorityTypeId ?? this.priorityTypeId,
      priorityTypeName:priorityTypeName??this.priorityTypeName,
      color: color ?? this.color,
      priorityType: priorityType ?? this.priorityType,
    );
  }
}
