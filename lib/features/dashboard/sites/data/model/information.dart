import '/common_libraries.dart';

class Information extends Equatable {
  bool isStatus;
  String? content;
  String? others;
  Information({
    this.isStatus = false,
    this.content,
    this.others
  });

  @override
  List<Object?> get props => [
        isStatus,
        content,
        others
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isStatus': isStatus,
      'content': content.toString(),
      'others':others.toString()
    };
  }

  String toJson() => json.encode(toMap());

  factory Information.fromJson(String source) => Information.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory Information.fromMap(Map<String, dynamic> map) {
    return Information(
      isStatus: map['isStatus'] as bool,
      content: map['content'],
      others:map['others']
    );
  }

  @override
  bool? get stringify => throw UnimplementedError();

  Information copyWith({
    bool? isStatus,
    String? content,
    String? others,
  }) {
    return Information(
      isStatus: isStatus ?? this.isStatus,
      content: content ?? this.content,
      others:others??this.others
    );
  }
}
