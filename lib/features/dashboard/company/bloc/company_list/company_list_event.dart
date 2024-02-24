part of 'company_list_bloc.dart';

class CompanyListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyListFiltered extends CompanyListEvent {}

class CompanyListLoaded extends CompanyListEvent {}

class CompanyDeleteClicked extends CompanyListEvent {
  final String id;

  CompanyDeleteClicked({required this.id});
}

class CompanyEditClicked extends CompanyListEvent {}
