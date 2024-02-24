import 'dart:async';

import '../../../../../../common_libraries.dart';
import '../../data/repository/sites_repository.dart';

part 'sites_event.dart';
part 'sites_state.dart';

class SitesBloc extends Bloc<SitesEvents, SitesState> {
  final SitesRepository sitesRepository;

  SitesBloc({required this.sitesRepository}) : super(const SitesState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<SitesListFiltered>(_onSitesListFiltered);
    on<SiteDelete>(_onSiteDelete);
  }

  Future<void> _onSitesListFiltered(
    SitesListFiltered event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(crudStatus: EntityStatus.loading));
    try {
      List<Sites> sitesList = await sitesRepository.getFilteredSitesList();

      emit(state.copyWith(
        sitesList: sitesList,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(crudStatus: EntityStatus.failure, message: "Failed to get sites list"));
    }
  }

  Future<void> _onSiteDelete(
    SiteDelete event,
    Emitter<SitesState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));
    try {
      EntityResponse response = await sitesRepository.deleteSites(int.parse(event.siteId));
      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          title: 'Success',
          message: "Site deleted successfully.",
        ));
        add(SitesListFiltered());
      } else {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        title: 'Failure',
        message: ErrorMessage('project').delete,
      ));
    }
  }
}
