import 'dart:convert';
import '/data/model/model.dart';
import '../../../../administration/masters/regions_timezones/data/model/model.dart';

class RegionsResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  List<Regions>? dataList;
  RegionsResponse({
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

  factory RegionsResponse.fromJson(String source) =>
      RegionsResponse.fromMap(json.decode(source));

  factory RegionsResponse.fromMap(Map<String, dynamic> map) {
    String message =
        (map['Message'] ?? (map['message'] ?? (map['Description'] ?? '')))
            .toString();
    message = message.replaceAll('"', '');
    return RegionsResponse(
        statusCode: map['statusCode'] ?? 200,
        isSuccess: map['isSuccess'] == null
            ? (map['Message'] ?? (map['message'] ?? ''))
                .toString()
                .contains('success')
            : map['isSuccess'] as bool,
        message: message,
        dataList: List.from(
          map['data'] != null ? (map['data'] != {} ? map['data'] : {}) : {},
        ).map((e) => Regions.fromMap(e)).toList());
  }
}

class Regions {
  int? id;
  String? name;
  List<SubRegion>? subRegions;
  Regions({required this.id, required this.name, this.subRegions});

  // set the field for equality of Regions
  @override
  List<Object?> get props => [id, name, subRegions];

  // return new Regions with updated fields
  Regions copyWith({int? id, String? name, List<SubRegion>? subRegions}) {
    return Regions(
        id: id ?? this.id,
        name: name ?? this.name,
        subRegions: this.subRegions);
  }

  // return the map of Regions
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  factory Regions.fromJson(String source) =>
      Regions.fromMap(json.decode(source));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  factory Regions.fromMap(Map<String, dynamic> map) {
    return Regions(
        id: map['id'] as int,
        name: map['name'] != null ? map['name'] as String : null,
        subRegions: List.from(
          map['subRegions'] != null
              ? (map['subRegions'] != {} ? map['subRegions'] : {})
              : {},
        ).map((e) => SubRegion.fromMap(e)).toList());
  }
}
