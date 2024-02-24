import 'dart:convert';

class SiteData {
  final List<Site> data;
  const SiteData({
    this.data = const [],
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory SiteData.fromMap(Map<String, dynamic> map) {
    return SiteData(
      data: List<Site>.from(
        (map['data']).map<Site>(
          (x) => Site.fromMap(x),
        ),
      ),
    );
  }

  factory SiteData.fromJson(String source) => SiteData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Site {
  final int? id;
  final String? name;

  const Site({
    this.id,
    this.name,
  });

  List<Object?> get props => [
        id,
        name,
      ];
  Site copyWith({
    int? id,
    String? name,
  }) {
    return Site(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'id': id,
    };
    return map;
  }

  @override
  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) => Site.fromMap(json.decode(source) as Map<String, dynamic>);
}
