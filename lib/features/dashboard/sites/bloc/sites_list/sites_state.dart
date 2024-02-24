part of 'sites_bloc.dart';

class SitesState extends Equatable {
  final List<Sites> sitesList;
  final EntityStatus crudStatus;
  final EntityStatus status;
  final String message;
  final String title;
  const SitesState({
    this.sitesList = const [],
    this.crudStatus = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.message = '',
    this.title = '',
  });

  @override
  List<Object?> get props => [
        title,
        status,
        sitesList,
        crudStatus,
        message,
      ];

  SitesState copyWith({
    List<Sites>? sitesList,
    EntityStatus? crudStatus,
    EntityStatus? status,
    String? message,
    String? title,
  }) {
    return SitesState(
      sitesList: sitesList ?? this.sitesList,
      crudStatus: crudStatus ?? this.crudStatus,
      status: status ?? this.status,
      message: message ?? this.message,
      title: title ?? this.title,
    );
  }
}
