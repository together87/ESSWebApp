import 'dart:async';

import '/common_libraries.dart';

part 'company_list_event.dart';
part 'company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  final BuildContext context;
  late CompanyRepository companyRepository;

  CompanyListBloc(this.context) : super(const CompanyListState()) {
    companyRepository = RepositoryProvider.of(context);
    _triggerEvents();
  }

  void _triggerEvents() {
    on<CompanyListLoaded>(_onCompanyListFiltered);
    on<CompanyDeleteClicked>(_onCompanyDeleteClicked);
  }

  /// get companies list from repository
  Future<void> _onCompanyListFiltered(
    CompanyListLoaded event,
    Emitter<CompanyListState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));
    try {
      List<Company> companies =
          await companyRepository.getFilteredCompanyList();
      emit(state.copyWith(
        companyList: companies,
        status: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: EntityStatus.failure,
          message: 'Failed to get companies list',
          title: 'Failure',
          deleteStatus: EntityStatus.failure));
    }
  }

  FutureOr<void> _onCompanyDeleteClicked(
      CompanyDeleteClicked event, Emitter<CompanyListState> emit) async {
    emit(state.copyWith(status: EntityStatus.loading));
    try {
      EntityResponse response = await companyRepository.deleteCompany(event.id);
      if (response.isSuccess) {
        emit(state.copyWith(
          status: EntityStatus.success,
          title: 'Success',
          message: response.message,
        ));
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
        message: ErrorMessage('company').delete,
      ));
    }
  }
}
