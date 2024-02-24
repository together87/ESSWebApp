part of 'company_details_bloc.dart';

class CompanyDetailsState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoader;
  final String message;
  final String title;
  final Company? company;
  final String view;

  const CompanyDetailsState({
    this.status = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.detailsLoader = EntityStatus.initial,
    this.company,
    this.view = "1",
  });

  @override
  List<Object?> get props => [status, message, title, company, detailsLoader, view];

  CompanyDetailsState copyWith({
    EntityStatus? status,
    String? message,
    String? title,
    EntityStatus? detailsLoader,
    Nullable<Company?>? company,
    String? view,
  }) {
    return CompanyDetailsState(
      status: status ?? this.status,
      message: message ?? this.message,
      title: title ?? this.title,
      company: company != null ? company.value : this.company,
      detailsLoader: detailsLoader ?? this.detailsLoader,
      view: view ?? this.view,
    );
  }
}
