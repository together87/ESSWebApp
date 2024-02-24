part of 'add_edit_company_bloc.dart';

class AddEditCompanyState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoaded;
  final String message;
  final String title;

  /// Filed company add-edit
  final String companyName;
  final String einNumber;
  final String mainContactName;
  final String mainContactEmail;
  final String mainContactPhone;
  final bool approvalStatus;
  final String hypercareValue;
  final String prequalificationMethod;

  /// List
  final List<String> hypercareValueList;
  final List<String> prequalificationList;

  /// Validation Message
  final String companyNameValidationMessage;

  const AddEditCompanyState({
    this.status = EntityStatus.initial,
    this.detailsLoaded = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.companyName = '',
    this.einNumber = '',
    this.mainContactName = '',
    this.mainContactEmail = '',
    this.mainContactPhone = '',
    this.approvalStatus = false,
    this.companyNameValidationMessage = '',
    this.hypercareValue = '',
    this.prequalificationMethod = '',
    this.hypercareValueList = const [],
    this.prequalificationList = const [],
  });

  @override
  List<Object?> get props => [
        status,
        detailsLoaded,
        message,
        title,
        companyName,
        einNumber,
        mainContactName,
        mainContactEmail,
        mainContactPhone,
        approvalStatus,
        companyNameValidationMessage,
        hypercareValueList,
        prequalificationList,
        hypercareValue,
        prequalificationMethod,
      ];

  AddEditCompanyState copyWith({
    EntityStatus? status,
    EntityStatus? detailsLoaded,
    String? message,
    String? title,
    String? companyName,
    String? einNumber,
    String? mainContactName,
    String? mainContactEmail,
    String? mainContactPhone,
    bool? approvalStatus,
    String? companyNameValidationMessage,
    List<String>? hypercareValueList,
    List<String>? prequalificationList,
    String? hypercareValue,
    String? prequalificationMethod,
  }) {
    return AddEditCompanyState(
      status: status ?? this.status,
      detailsLoaded: detailsLoaded ?? this.detailsLoaded,
      message: message ?? this.message,
      title: title ?? this.title,
      companyName: companyName ?? this.companyName,
      einNumber: einNumber ?? this.einNumber,
      mainContactName: mainContactName ?? this.mainContactName,
      mainContactEmail: mainContactEmail ?? this.mainContactEmail,
      mainContactPhone: mainContactPhone ?? this.mainContactPhone,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      companyNameValidationMessage: companyNameValidationMessage ?? this.companyNameValidationMessage,
      hypercareValueList: hypercareValueList ?? this.hypercareValueList,
      prequalificationList: prequalificationList ?? this.prequalificationList,
      hypercareValue: hypercareValue ?? this.hypercareValue,
      prequalificationMethod: prequalificationMethod ?? this.prequalificationMethod,
    );
  }
}
