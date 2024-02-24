import '/common_libraries.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvents, UserListState> {
  final BuildContext context;
  late UsersRepository usersRepository;

  UserListBloc(this.context) : super(const UserListState()) {
    usersRepository = RepositoryProvider.of(context);

    on<UserListFiltered>(_onUserListFiltered);
    on<UserDetailUserDeleted>(_onUserDetailUserDeleted);
  }

  Future<void> _onUserListFiltered(
    UserListFiltered event,
    Emitter<UserListState> emit,
  ) async {
    emit(state.copyWith(projectCrud: EntityStatus.loading));
    try {
      FilteredUsersData filteredUsersData = await usersRepository.getFilteredUserList();

      emit(state.copyWith(
        userList: filteredUsersData.data,
        projectCrud: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(projectCrud: EntityStatus.failure, message: "Failed to get user list"));
    }
  }

  Future<void> _onUserDetailUserDeleted(
    UserDetailUserDeleted event,
    Emitter<UserListState> emit,
  ) async {
    emit(state.copyWith(status: EntityStatus.loading));
    try {
      EntityResponse response = await usersRepository.deleteUser(event.userId);
      if (response.isSuccess) {
        emit(state.copyWith(
          status: response.isSuccess ? EntityStatus.success : EntityStatus.failure,
          title: 'Success',
          message: response.message,
        ));
        add(const UserListFiltered());
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
        message: ErrorMessage('user').delete,
      ));
    }
  }
}
