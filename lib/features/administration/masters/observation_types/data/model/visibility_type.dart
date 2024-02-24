import 'dart:convert';

import 'package:equatable/equatable.dart';


class VisibilityTypeResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<VisibilityType>? dataList;
  VisibilityTypeResponse({
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
      'datalist': dataList,
    };
  }

  String toJson() => json.encode(toMap());

  factory VisibilityTypeResponse.fromJson(String source) =>
      VisibilityTypeResponse.fromMap(json.decode(source));

  factory VisibilityTypeResponse.fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return VisibilityTypeResponse(
        statusCode: map['StatusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != {} ? map['data'] : {},
        ).map((e) => VisibilityType.fromMap(e)).toList());
  }

  
  factory VisibilityTypeResponse.fromString(String map) {
    return VisibilityTypeResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      dataList: null,
    );
  }
}



class VisibilityType {
  final int? id;
  final String? name;

  const VisibilityType({this.id, this.name});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory VisibilityType.fromMap(Map<String, dynamic> map) {
    return VisibilityType(
      id: map['id'] as int,
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VisibilityType.fromJson(String source) => VisibilityType.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool? get stringify => throw UnimplementedError();

  VisibilityType copyWith({
    int? id,
    String? name,
  }) {
    return VisibilityType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
