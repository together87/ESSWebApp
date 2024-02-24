import 'dart:convert';

import 'package:equatable/equatable.dart';

class SeverityLevel {
  final int? id;
  final String? level;

  const SeverityLevel({this.id, this.level});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'level': level,
    };
  }

  factory SeverityLevel.fromMap(Map<String, dynamic> map) {
    return SeverityLevel(
      id: map['id'] as int,
      level: map['level'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SeverityLevel.fromJson(String source) => SeverityLevel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool? get stringify => throw UnimplementedError();

  SeverityLevel copyWith({
    int? id,
    String? level,
  }) {
    return SeverityLevel(
      id: id ?? this.id,
      level: level ?? this.level,
    );
  }
}
