part of 'company_details_bloc.dart';

class CompanyDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// event to load the company detail
class CompanyDetailsLoaded extends CompanyDetailsEvent {}

class CompanyDetailsTabSubViewChanged extends CompanyDetailsEvent {
  final String view;
  CompanyDetailsTabSubViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}
