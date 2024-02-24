import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

class PriorityResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<PriorityType>? dataList;
  PriorityType? data;
  PriorityResponse({
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

  factory PriorityResponse.fromJson(String source) =>
      PriorityResponse.fromMap(json.decode(source));

  factory PriorityResponse.fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return PriorityResponse(
        statusCode: map['StatusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != {} ? map['data'] : {},
        ).map((e) => PriorityType.fromMap(e)).toList());
  }
  factory PriorityResponse.fromJson2(String source) =>
      PriorityResponse.fromMap2(json.decode(source));

  factory PriorityResponse.fromMap2(Map<String, dynamic> map) {
    String message = (map['Message'] ?? (map['Description'] ?? '')).toString();
    message = message.replaceAll('"', '');
    return PriorityResponse(
      statusCode: map['StatusCode'] ?? 200,
      isSuccess: map['isSuccess'] == null
          ? (map['Message'] ?? (map['Message'] ?? ''))
              .toString()
              .contains('success')
          : map['isSuccess'] as bool,
      message: message,
      data: PriorityType.fromMap(map['data'] != null ? map['data']  as Map<String, dynamic> : {"id":0,"name":"null"} ),
    );
  }
  factory PriorityResponse.fromString(String map) {
    return PriorityResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      dataList: const [],
      data: null,
    );
  }
}
