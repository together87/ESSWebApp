part of 'sites_bloc.dart';

class SitesEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class SitesListFiltered extends SitesEvents {}

class SiteDelete extends SitesEvents {
  final String siteId;
  SiteDelete({required this.siteId});

  @override
  List<Object> get props => [siteId];
}
