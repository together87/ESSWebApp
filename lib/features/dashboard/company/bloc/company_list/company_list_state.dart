part of 'company_list_bloc.dart';

class CompanyListState extends Equatable {
  final EntityStatus status;
  final EntityStatus deleteStatus;
  final String message;
  final String title;

  final List<Company> companyList;

  const CompanyListState({
    this.status = EntityStatus.initial,
    this.deleteStatus = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.companyList = const [],
  });

  @override
  List<Object?> get props => [
        status,
        deleteStatus,
        message,
        title,
        companyList,
      ];

  CompanyListState copyWith({
    EntityStatus? status,
    EntityStatus? deleteStatus,
    String? message,
    String? title,
    List<Company>? companyList,
  }) {
    return CompanyListState(
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      message: message ?? this.message,
      title: title ?? this.title,
      companyList: companyList ?? this.companyList,
    );
  }
}
