import 'dart:convert';

import 'package:equatable/equatable.dart';

class PriorityType {
  final int? id;
  final String? name;
   
  const PriorityType({this.id, this.name});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PriorityType.fromMap(Map<String, dynamic> map) {
    return PriorityType(
      id: map['id'] as int,
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PriorityType.fromJson(String source) => PriorityType.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool? get stringify => throw UnimplementedError();

  PriorityType copyWith({
    int? id,
    String? name,
  }) {
    return PriorityType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
