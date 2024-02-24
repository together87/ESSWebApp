import 'dart:async';

import 'package:ecosys_safety/features/dashboard/company/data/model/company_create.dart';

import '/common_libraries.dart';

part 'add_edit_company_event.dart';
part 'add_edit_company_state.dart';

class AddEditCompanyBloc
    extends Bloc<AddEditCompanyEvent, AddEditCompanyState> {
  final BuildContext context;
  late CompanyRepository companyRepository;

  AddEditCompanyBloc(this.context) : super(const AddEditCompanyState()) {
    companyRepository = RepositoryProvider.of(context);
    _triggerEvents();
  }

  void _triggerEvents() {
    on<AddEditCompanyNameChanged>(_onAddEditCompanyNameChanged);
    on<AddEditCompanyEINNumberChanged>(_onAddEditCompanyEINNumberChanged);
    on<AddEditMainContactNameChanged>(_onAddEditMainContactNameChanged);
    on<AddEditMainContactEmailChanged>(_onAddEditMainContactEmailChanged);
    on<AddEditMainContactPhoneChanged>(_onAddEditMainContactPhoneChanged);
    on<AddEditApprovalStatusChanged>(_onAddEditApprovalStatusChanged);
    on<AddEditCompanyLoaded>(_onAddEditCompanyLoaded);
    on<AddEditCompanyAdded>(_onAddEditCompanyAdded);
    on<AddEditCompanyEdited>(_onAddEditCompanyEdited);
  }

  void _onAddEditCompanyNameChanged(
    AddEditCompanyNameChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      companyName: event.name,
      companyNameValidationMessage: '',
    ));
  }

  void _onAddEditCompanyEINNumberChanged(
    AddEditCompanyEINNumberChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      einNumber: event.number,
    ));
  }

  void _onAddEditMainContactNameChanged(
    AddEditMainContactNameChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      mainContactName: event.name,
    ));
  }

  void _onAddEditMainContactEmailChanged(
    AddEditMainContactEmailChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      mainContactEmail: event.email,
    ));
  }

  void _onAddEditMainContactPhoneChanged(
    AddEditMainContactPhoneChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      mainContactPhone: event.phone,
    ));
  }

  void _onAddEditApprovalStatusChanged(
    AddEditApprovalStatusChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      approvalStatus: event.approvalStatus,
    ));
  }

  FutureOr<void> _onAddEditCompanyAdded(
      AddEditCompanyAdded event, Emitter<AddEditCompanyState> emit) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await companyRepository.addCompany(
          CompanyCreate(
              name: state.companyName,
              einNumber: state.einNumber,
              contactName: state.mainContactName,
              contactEmail: state.mainContactEmail,
              hypercareId: null,
              preQualificationMethodId: null,
              contactPhone: state.mainContactPhone,
              approved: state.approvalStatus),
        );
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            title: 'Success',
            message: "Company added successfully",
          ));
        } else if (response.statusCode == 409) {
          emit(state.copyWith(
              message: response.message,
              title: 'Failure',
              status: EntityStatus.failure));
        } else {
          emit(state.copyWith(
            status: EntityStatus.failure,
            title: 'Failure',
            message: ErrorMessage('company').add,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: ErrorMessage('company').add,
        ));
      }
    }
  }

  FutureOr<void> _onAddEditCompanyEdited(
      AddEditCompanyEdited event, Emitter<AddEditCompanyState> emit) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await companyRepository.editCompany(
          CompanyCreate(
              id: event.companyId,
              name: state.companyName,
              einNumber: state.einNumber,
              contactName: state.mainContactName,
              contactEmail: state.mainContactEmail,
              hypercareId: null,
              preQualificationMethodId: null,
              contactPhone: state.mainContactPhone,
              approved: state.approvalStatus),
        );
        if (response.isSuccess) {
          emit(state.copyWith(
            status: EntityStatus.success,
            title: 'Success',
            message: "Company edited successfully",
          ));
        } else if (response.statusCode == 409) {
          emit(state.copyWith(
              message: response.message,
              title: 'Failure',
              status: EntityStatus.failure));
        } else {
          emit(state.copyWith(
            status: EntityStatus.failure,
            title: 'Failure',
            message: ErrorMessage('company').add,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          title: 'Failure',
          message: ErrorMessage('company').add,
        ));
      }
    }
  }

  bool _checkValidation(Emitter<AddEditCompanyState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.companyName)) {
      emit(state.copyWith(
          companyNameValidationMessage:
              FormValidationMessage(fieldName: 'Company Name')
                  .requiredMessage));
      success = false;
    }
    return success;
  }

  FutureOr<void> _onAddEditCompanyLoaded(
      AddEditCompanyLoaded event, Emitter<AddEditCompanyState> emit) async {
    emit(state.copyWith(detailsLoaded: EntityStatus.loading));

    try {
      Company company = await companyRepository.getCompanyById(event.companyId);
      emit(state.copyWith(
          companyName: company.companyName,
          einNumber: company.ein,
          mainContactName: company.mainContact,
          mainContactEmail: company.contactEmail,
          mainContactPhone: company.phone,
          hypercareValue: company.hyperCareValue,
          approvalStatus: company.approvalStatus,
          prequalificationMethod: company.preQualificationMethod,
          detailsLoaded: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(
          detailsLoaded: EntityStatus.failure,
          message: "Failed to get company details"));
    }
  }
}
