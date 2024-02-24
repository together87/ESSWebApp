import '../../data/repository/sites_repository.dart';
import '/common_libraries.dart';

part 'site_details_event.dart';
part 'site_details_state.dart';

class SiteDetailsBloc extends Bloc<SiteDetailsEvent, SiteDetailsState> {
  final BuildContext context;
  late SitesRepository sitesRepository;
  final String siteId;
  SiteDetailsBloc(
    this.context,
    this.siteId,
  ) : super(const SiteDetailsState()) {
    sitesRepository = RepositoryProvider.of(context);
    _triggerEvents();
  }

  void _triggerEvents() {
    on<SiteDetailsLoaded>(_onSiteDetailsLoaded);
    on<SiteDetailsTabSubViewChanged>(_onSiteDetailsTabSubViewChanged);
  }

  Future<void> _onSiteDetailsLoaded(
    SiteDetailsLoaded event,
    Emitter<SiteDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(detailsLoader: EntityStatus.loading));
      Sites sites = await sitesRepository.getSitesById(siteId);
      emit(
        state.copyWith(sites: Nullable.value(sites), detailsLoader: EntityStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(detailsLoader: EntityStatus.failure),
      );
    }
  }

  Future<void> _onSiteDetailsTabSubViewChanged(
    SiteDetailsTabSubViewChanged event,
    Emitter<SiteDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        view: event.view,
      ));
    } catch (e) {
      emit(state.copyWith(status: EntityStatus.failure));
    }
  }
}
