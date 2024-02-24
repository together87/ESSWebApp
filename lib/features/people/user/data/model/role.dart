import 'dart:convert';

import 'package:equatable/equatable.dart';

class RoleData {
  final List<Role> data;
  const RoleData({
    this.data = const [],
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory RoleData.fromMap(Map<String, dynamic> map) {
    return RoleData(
      data: List<Role>.from(
        (map['data']).map<Role>(
          (x) => Role.fromMap(x),
        ),
      ),
    );
  }

  factory RoleData.fromJson(String source) => RoleData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Role extends Equatable {
  final int? id;
  final String name;
  const Role({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  Role copyWith({
    int? id,
    String? name,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source) as Map<String, dynamic>);
}
