import '/common_libraries.dart';

class Document extends Equatable {
  final int id;
  final String? uri;
  final String? fileName;
  final String? shortDescription;
  final String? upload;

  const Document({
    required this.id,
    this.uri,
    this.fileName,
    this.shortDescription,
    this.upload,
  });

  @override
  List<Object?> get props {
    return [
      id,
      uri,
      fileName,
      upload,
      shortDescription,
    ];
  }

  Document copyWith({
    int? id,
    String? uri,
    String? fileName,
    String? upload,
    String? shortDescription,
  }) {
    return Document(
      id: id ?? this.id,
      uri: uri ?? this.uri,
      fileName: fileName ?? this.fileName,
      upload: upload ?? this.upload,
      shortDescription: shortDescription ?? this.shortDescription,
    );
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] as int,
      uri: map['uri'] != null ? map['uri'] as String : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      shortDescription: map['shortDescription'] != null ? map['shortDescription'] as String : null,
      upload: map['upload'] != null ? map['upload'] as String : null,
    );
  }

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source) as Map<String, dynamic>);
}
