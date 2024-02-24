import 'dart:convert';

class SubRegion {
  int? id;
  String? name;
  int? parentId;
  String? parentName;
  bool? isSelected;

  SubRegion(
      {this.id, this.name, this.parentId, this.parentName, this.isSelected});

  SubRegion.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    parentName = json['parentName'];
    id = json['id'];
    name = json['name'];
  }

  // return the map of region
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
      'parentName': parentName.toString(),
      'parentId': parentId.toString(),
    };
    return map;
  }

  // return json of region for payload
  String toJson() => json.encode(toMap());

  factory SubRegion.fromMap(Map<String, dynamic> map) {
    return SubRegion(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }
}
