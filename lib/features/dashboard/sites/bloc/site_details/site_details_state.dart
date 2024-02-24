part of 'site_details_bloc.dart';

class SiteDetailsState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoader;
  final String message;
  final String title;
  final String view;

  final Sites? sites;

  const SiteDetailsState({
    this.status = EntityStatus.initial,
    this.detailsLoader = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.view = '1',
    this.sites,
  });

  @override
  List<Object?> get props => [
        status,
        detailsLoader,
        message,
        title,
        sites,
        view,
      ];

  SiteDetailsState copyWith({
    EntityStatus? status,
    EntityStatus? detailsLoader,
    String? message,
    String? title,
    String? view,
    Nullable<Sites?>? sites,
  }) {
    return SiteDetailsState(
      status: status ?? this.status,
      detailsLoader: detailsLoader ?? this.detailsLoader,
      message: message ?? this.message,
      title: title ?? this.title,
      view: view ?? this.view,
      sites: sites != null ? sites.value : this.sites,
    );
  }
}
