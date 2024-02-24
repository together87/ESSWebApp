import 'dart:convert';

import '/data/model/model.dart';

class Region {
  int? id;
  String? name;

  Region({required this.id, required this.name});

  // set the field for equality of region
  @override
  List<Object?> get props => [
        id,
        name,
      ];

  // return new region with updated fields
  Region copyWith({int? id, String? name}) {
    return Region(id: id ?? this.id, name: name ?? this.name);
  }

  // return the map of region
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
 
  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
        id: map['id'] as int,
        name: map['name'] != null ? map['name'] as String : null);
  }
}
