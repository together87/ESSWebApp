import 'package:ecosys_safety/common_libraries.dart';

class CompanyData {
  CompanyData({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Company data;

  factory CompanyData.fromMap(Map<String, dynamic> map) {
    return CompanyData(
      data: Company.fromMap(map['data']),
      message: map['message'],
    );
  }

  factory CompanyData.fromJson(String source) =>
      CompanyData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Company extends Entity {
  final dynamic companyId;
  final String companyName;
  final String mainContact;
  final String contactEmail;
  final String ein;
  final String phone;
  final String? hyperCareValue;
  final bool approvalStatus;
  final String? preQualificationMethod;
  final String grade;
  final String gradeDate;

  const Company({
    super.id,
    this.companyId = '',
    this.companyName = '',
    this.contactEmail = '',
    this.mainContact = '',
    this.ein = '',
    this.phone = '',
    this.hyperCareValue = '',
    this.approvalStatus = false,
    this.preQualificationMethod = '',
    this.grade = '',
    this.gradeDate = '',
  });

  @override
  List<Object?> get props => [
        companyId,
        companyName,
        contactEmail,
        mainContact,
        ein,
        phone,
        hyperCareValue,
        approvalStatus,
        preQualificationMethod,
        grade,
        gradeDate,
      ];

  factory Company.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Company(
      id: entity.id,
      companyId: map['id'],
      companyName: map['name'] ?? '',
      contactEmail: map['contactEmail'],
      mainContact: map['contactName'] ?? '',
      ein: map['einNumber'] ?? '',
      approvalStatus: map['approved'] ?? '',
      phone: map['contactPhone'] ?? '',
      hyperCareValue: map['hypercare'] ?? '',
      preQualificationMethod: map['preQualificationMethodId'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'companyName': companyName,
      'mainContact': mainContact,
      'ein': ein,
      'phone': phone,
      'hyperCareValue': hyperCareValue,
      'approvalStatus': approvalStatus,
      'preQualificationMethod': preQualificationMethod,
      'grade': grade,
      'gradeDate': gradeDate,
    };
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Number': companyId,
      'Name': companyName,
      'Main Contact': mainContact,
      'Contact Email': contactEmail,
      'Action': Icons.delete,
    };
  }

  Company copyWith({
    String? companyId,
    String? companyName,
    String? mainContact,
    String? ein,
    String? phone,
    String? hyperCareValue,
    bool? approvalStatus,
    String? preQualificationMethod,
    String? grade,
    String? gradeDate,
  }) {
    return Company(
      companyId: companyId ?? this.companyId,
      mainContact: mainContact ?? this.mainContact,
      companyName: companyName ?? this.companyName,
      ein: ein ?? this.ein,
      phone: phone ?? this.phone,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      grade: grade ?? this.grade,
      gradeDate: gradeDate ?? this.gradeDate,
      preQualificationMethod:
          preQualificationMethod ?? this.preQualificationMethod,
      hyperCareValue: hyperCareValue ?? this.hyperCareValue,
    );
  }
}
