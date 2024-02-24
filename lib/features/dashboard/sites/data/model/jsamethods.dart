import 'dart:convert';
import '/data/model/model.dart';

class JsaMethodResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<JsaMethod>? dataList;
  JsaMethodResponse({
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

  factory JsaMethodResponse.fromJson(String source) =>
      JsaMethodResponse.fromMap(json.decode(source));

  factory JsaMethodResponse.fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return JsaMethodResponse(
        statusCode: map['statusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != null ? (map['data'] != {} ? map['data'] : {}) : {},
        ).map((e) => JsaMethod.fromMap(e)).toList());
  }
}

class JsaMethod {
  int? id;
  String? name;

  JsaMethod({required this.id, required this.name});

  // set the field for equality of JsaMethod
  @override
  List<Object?> get props => [
        id,
        name,
      ];

  // return new JsaMethod with updated fields
  JsaMethod copyWith({int? id, String? name}) {
    return JsaMethod(id: id ?? this.id, name: name ?? this.name);
  }

  // return the map of JsaMethod
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  JsaMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  factory JsaMethod.fromMap(Map<String, dynamic> map) {
    return JsaMethod(
        id: map['id'] as int,
        name: map['name'] != null ? map['name'] as String : null);
  }
}
