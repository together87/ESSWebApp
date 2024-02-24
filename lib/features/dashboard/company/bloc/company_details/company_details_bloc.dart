import 'dart:async';

import '/common_libraries.dart';

part 'company_details_event.dart';
part 'company_details_state.dart';

class CompanyDetailsBloc extends Bloc<CompanyDetailsEvent, CompanyDetailsState> {
  final BuildContext context;
  final String companyId;
  late CompanyRepository companyRepository;

  CompanyDetailsBloc(this.context, this.companyId) : super(const CompanyDetailsState()) {
    companyRepository = RepositoryProvider.of(context);
    _triggerEvents();
  }

  void _triggerEvents() {
    on<CompanyDetailsLoaded>(_onCompanyDetailsLoaded);
    on<CompanyDetailsTabSubViewChanged>(_onCompanyDetailsTabSubViewChanged);
  }

  FutureOr<void> _onCompanyDetailsLoaded(CompanyDetailsLoaded event, Emitter<CompanyDetailsState> emit) async {
    emit(state.copyWith(detailsLoader: EntityStatus.loading));
    try {
      Company company = await companyRepository.getCompanyById(companyId);
      emit(
        state.copyWith(company: Nullable.value(company), detailsLoader: EntityStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: EntityStatus.failure, detailsLoader: EntityStatus.failure, message: "Failed to get company details"),
      );
    }
  }

  Future<void> _onCompanyDetailsTabSubViewChanged(
    CompanyDetailsTabSubViewChanged event,
    Emitter<CompanyDetailsState> emit,
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
