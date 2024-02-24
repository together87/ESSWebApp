import 'dart:convert';

import '/data/model/model.dart';

class DirectorData {
  final List<Director> data;
  const DirectorData({
    this.data = const [],
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory DirectorData.fromMap(Map<String, dynamic> map) {
    return DirectorData(
      data: List<Director>.from(
        (map['data']).map<Director>(
          (x) => Director.fromMap(x),
        ),
      ),
    );
  }

  factory DirectorData.fromJson(String source) => DirectorData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Director extends Entity {
  const Director({
    super.id,
    super.name,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        active,
      ];
  Director copyWith({
    String? id,
    String? name,
  }) {
    return Director(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
    };

    if (id != null) {
      return map..addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  @override
  factory Director.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Director(
      id: entity.id,
      name: entity.name,
    );
  }

  String toJson() => json.encode(toMap());

  factory Director.fromJson(String source) => Director.fromMap(json.decode(source) as Map<String, dynamic>);
}
