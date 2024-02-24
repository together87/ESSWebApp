// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

class AwarenessCategoryResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<AwarenessCategory>? dataList;
  AwarenessCategory? data;
  AwarenessCategoryResponse({
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

  factory AwarenessCategoryResponse.fromJson(String source) =>
      AwarenessCategoryResponse.fromMap(json.decode(source));

  factory AwarenessCategoryResponse.fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return AwarenessCategoryResponse(
        statusCode: map['StatusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != {} ? map['data'] : {},
        ).map((e) => AwarenessCategory.fromMap(e)).toList());
  }

  factory AwarenessCategoryResponse.fromJson2(String source) =>
      AwarenessCategoryResponse.fromMap2(json.decode(source));

  factory AwarenessCategoryResponse.fromMap2(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return AwarenessCategoryResponse(
      statusCode: map['StatusCode'] ?? 200,
      isSuccess: map['isSuccess'] == null
          ? (map['Message'] ?? (map['message'] ?? ''))
              .toString()
              .contains('success')
          : map['isSuccess'] as bool,
      message: message,
      data: AwarenessCategory.fromMap(map['data'] != null
          ? map['data'] as Map<String, dynamic>
          : {"id": 0, "name": "null"}),
    );
  }

  factory AwarenessCategoryResponse.fromString(String map) {
    return AwarenessCategoryResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      dataList: null,
      data: null,
    );
  }
}

class AwarenessCategory extends Equatable {
  int? id;
  String? name;

  AwarenessCategory(
      {this.id,
      this.name,
      });

  @override
  List<Object?> get props => [
        id,
        name,

      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toString(),

    };
  }

  String toJson() => json.encode(toMap());

  factory AwarenessCategory.fromJson(String source) => AwarenessCategory.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory AwarenessCategory.fromMap(Map<String, dynamic> map) {
    return AwarenessCategory(
      id: map['id'] as int,
      name: map['name'],

    );
  }

  @override
  bool? get stringify => throw UnimplementedError();

  AwarenessCategory copyWith({
    int? id,
    String? name,

  }) {
    return AwarenessCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
