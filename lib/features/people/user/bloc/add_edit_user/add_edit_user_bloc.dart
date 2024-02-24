import '../../../../dashboard/sites/data/repository/sites_repository.dart';
import '/common_libraries.dart';

part 'add_edit_user_event.dart';
part 'add_edit_user_state.dart';

class AddEditUsersBloc extends Bloc<AddEditUsersEvent, AddEditUsersState> {
  final BuildContext context;
  late UsersRepository usersRepository;
  late SitesRepository sitesRepository;

  AddEditUsersBloc(this.context) : super(const AddEditUsersState()) {
    usersRepository = context.read();
    sitesRepository = context.read();
    on<AddEditUserLoaded>(_onAddEditUserLoaded);
    on<AddEditUserFirstNameChanged>(_onAddEditUserFirstNameChanged);
    on<AddEditUserRoleListLoaded>(_onAddEditUserRoleListLoaded);
    on<AddEditUserRoleChanged>(_onAddEditUserRoleChanged);
    on<AddEditUserItemSiteChanged>(_onAddEditUserItemSiteChanged);
    on<AddEditUserLastNameChanged>(_onAddEditUserLastNameChanged);
    on<AddEditUserTitleNameChanged>(_onAddEditUserTitleNameChanged);
    on<AddEditUserEmailNameChanged>(_onAddEditUserEmailNameChanged);
    on<AddEditUserPhoneChanged>(_onAddEditUserPhoneChanged);
    on<AddEditUserSiteListLoaded>(_onAddEditUserSiteListLoaded);
    on<AddEditUserAdded>(_onAddEditUserAdded);
    on<AddEditUserEdited>(_onAddEditUserEdited);
  }

  Future<void> _onAddEditUserSiteListLoaded(
    AddEditUserSiteListLoaded event,
    Emitter<AddEditUsersState> emit,
  ) async {
    try {
      List<Site> siteList = await sitesRepository.getSiteListForProject();

      emit(
        state.copyWith(siteList: siteList, detailsLoaded: EntityStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(
        message: '',
        detailsLoaded: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onAddEditUserRoleListLoaded(
    AddEditUserRoleListLoaded event,
    Emitter<AddEditUsersState> emit,
  ) async {
    try {
      List<Role> roleList = await usersRepository.getUserRoles();
      emit(state.copyWith(roleList: roleList));
    } catch (e) {}
  }

  void _onAddEditUserRoleChanged(
    AddEditUserRoleChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      role: Nullable.value(event.role),
      roleValidationMessage: '',
    ));
  }

  void _onAddEditUserItemSiteChanged(
    AddEditUserItemSiteChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      site: Nullable.value(event.site),
      siteValidationMessage: '',
    ));
  }

  Future<void> _onAddEditUserLoaded(
    AddEditUserLoaded event,
    Emitter<AddEditUsersState> emit,
  ) async {
    emit(state.copyWith(detailsLoaded: EntityStatus.loading));

    try {
      User user = await usersRepository.getUserById(event.userId);
      emit(
        state.copyWith(
          userTitle: user.title,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          userPhone: user.mobileNumber,
          site: Nullable.value(Site(
            id: user.siteId,
            name: user.siteName,
          )),
          role: Nullable.value(Role(id: user.userRoleId, name: user.roleName)),
          detailsLoaded: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(detailsLoaded: EntityStatus.failure, message: "Failed to get user details"));
    }
  }

  void _onAddEditUserFirstNameChanged(
    AddEditUserFirstNameChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      firstName: event.firstName,
      firstNameValidationMessage: '',
    ));
  }

  void _onAddEditUserTitleNameChanged(
    AddEditUserTitleNameChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      userTitle: event.userTitle,
    ));
  }

  void _onAddEditUserPhoneChanged(
    AddEditUserPhoneChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      userPhone: event.userPhone,
    ));
  }

  void _onAddEditUserEmailNameChanged(
    AddEditUserEmailNameChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
      emailValidationMessage: '',
    ));
  }

  void _onAddEditUserLastNameChanged(
    AddEditUserLastNameChanged event,
    Emitter<AddEditUsersState> emit,
  ) {
    emit(state.copyWith(
      lastName: event.lastName,
      lastNameValidationMessage: '',
    ));
  }

  Future<void> _onAddEditUserAdded(
    AddEditUserAdded event,
    Emitter<AddEditUsersState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await usersRepository.addUser(state.user);

        if (response.isSuccess) {
          emit(state.copyWith(status: EntityStatus.success, message: "User added successfully.", title: 'success'));
        } else {
          if (response.message.contains('Email')) {
            emit(state.copyWith(emailValidationMessage: response.message, status: EntityStatus.initial, title: 'failure'));
          } else {
            emit(state.copyWith(status: EntityStatus.failure, message: response.message, title: 'failure'));
          }
        }
      } catch (e) {
        emit(state.copyWith(status: EntityStatus.failure, message: ErrorMessage('user').add, title: 'failure'));
      }
    }
  }

  Future<void> _onAddEditUserEdited(
    AddEditUserEdited event,
    Emitter<AddEditUsersState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));
      try {
        EntityResponse response = await usersRepository.editUser(state.user.copyWith(id: event.userId));

        if (response.isSuccess) {
          emit(state.copyWith(status: EntityStatus.success, message: response.message, title: 'Success'));
        } else {
          if (response.message.contains('Email')) {
            emit(state.copyWith(
              emailValidationMessage: response.message,
              status: EntityStatus.initial,
            ));
          } else {
            emit(state.copyWith(status: EntityStatus.failure, message: response.message, title: 'Failure'));
          }
        }
      } catch (e) {
        emit(state.copyWith(status: EntityStatus.failure, message: ErrorMessage('user').edit, title: 'Failure'));
      }
    }
  }

  bool _checkValidation(Emitter<AddEditUsersState> emit) {
    bool success = true;
    if (Validation.isEmpty(state.firstName)) {
      emit(state.copyWith(firstNameValidationMessage: FormValidationMessage(fieldName: 'First name').requiredMessage));
      success = false;
    }

    if (Validation.isEmpty(state.lastName)) {
      emit(state.copyWith(lastNameValidationMessage: FormValidationMessage(fieldName: 'Last name').requiredMessage));
      success = false;
    }

    if (state.role == null) {
      emit(state.copyWith(roleValidationMessage: FormValidationMessage(fieldName: 'Role').requiredMessage));
      success = false;
    }

    if (state.site == null) {
      emit(state.copyWith(siteValidationMessage: FormValidationMessage(fieldName: 'Site').requiredMessage));
      success = false;
    }

    if (Validation.isEmpty(state.email)) {
      emit(state.copyWith(emailValidationMessage: FormValidationMessage(fieldName: 'Email').requiredMessage));
      success = false;
    } else if (!Validation.isEmail(state.email)) {
      emit(state.copyWith(emailValidationMessage: FormValidationMessage.emailValidationMessage));
      success = false;
    }
    return success;
  }
}
