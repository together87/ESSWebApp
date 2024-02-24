part of 'add_edit_company_bloc.dart';

class AddEditCompanyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEditCompanyNameChanged extends AddEditCompanyEvent {
  final String name;
  AddEditCompanyNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class AddEditCompanyLoaded extends AddEditCompanyEvent {
  final String companyId;
  AddEditCompanyLoaded({required this.companyId});
  @override
  List<Object> get props => [companyId];
}

class AddEditCompanyEINNumberChanged extends AddEditCompanyEvent {
  final String number;
  AddEditCompanyEINNumberChanged({required this.number});

  @override
  List<Object> get props => [number];
}

class AddEditMainContactNameChanged extends AddEditCompanyEvent {
  final String name;
  AddEditMainContactNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class AddEditMainContactEmailChanged extends AddEditCompanyEvent {
  final String email;
  AddEditMainContactEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class AddEditMainContactPhoneChanged extends AddEditCompanyEvent {
  final String phone;
  AddEditMainContactPhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];
}

class AddEditApprovalStatusChanged extends AddEditCompanyEvent {
  final bool approvalStatus;
  AddEditApprovalStatusChanged({required this.approvalStatus});

  @override
  List<Object> get props => [approvalStatus];
}

/// event to add company
class AddEditCompanyAdded extends AddEditCompanyEvent {}

/// event to edit company
class AddEditCompanyEdited extends AddEditCompanyEvent {
  final String companyId;
  AddEditCompanyEdited({required this.companyId});

  @override
  List<Object> get props => [companyId];
}
