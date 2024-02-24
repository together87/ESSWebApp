part of 'site_details_bloc.dart';

class SiteDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// event to load the site detail
class SiteDetailsLoaded extends SiteDetailsEvent {}

class SiteDetailsTabSubViewChanged extends SiteDetailsEvent {
  final String view;
  SiteDetailsTabSubViewChanged({required this.view});

  @override
  List<Object> get props => [view];
}
