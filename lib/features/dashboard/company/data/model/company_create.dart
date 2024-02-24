import '../../../../../common_libraries.dart';

class CompanyCreate extends Equatable {
  final String? id;
  final String name;
  final String einNumber;
  final bool approved;
  final String contactName;
  final String contactEmail;
  final String contactPhone;
  final String? hypercareId;
  final String? preQualificationMethodId;

  const CompanyCreate({
    this.id,
    this.name = '',
    this.einNumber = '',
    this.approved = false,
    this.contactName = '',
    this.contactEmail = '',
    this.contactPhone = '',
    this.hypercareId = '',
    this.preQualificationMethodId = '',
  });

  @override
  List<Object?> get props => [
        name,
        einNumber,
        approved,
        contactName,
        contactEmail,
        contactPhone,
        hypercareId,
        preQualificationMethodId,
      ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'einNumber': einNumber,
      'approved': approved,
      'contactName': contactName,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'hypercareId': hypercareId,
      'preQualificationMethodId': preQualificationMethodId
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  String toJson() => json.encode(toMap());

  CompanyCreate copyWith(
      {String? id,
      String? name,
      String? einNumber,
      bool? approved,
      String? contactName,
      String? contactEmail,
      String? contactPhone,
      String? hypercareId,
      String? preQualificationMethodId}) {
    return CompanyCreate(
      id: id ?? this.id,
      name: name ?? this.name,
      einNumber: einNumber ?? this.einNumber,
      approved: approved ?? this.approved,
      contactName: contactName ?? this.contactName,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      hypercareId: hypercareId ?? this.hypercareId,
      preQualificationMethodId:
          preQualificationMethodId ?? this.preQualificationMethodId,
    );
  }
}
