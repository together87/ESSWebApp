import '/common_libraries.dart';

part 'action_item_detail_event.dart';
part 'action_item_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final BuildContext context;
  final String userId;
  late UsersRepository usersRepository;

  UserDetailBloc(
    this.context,
    this.userId,
  ) : super(const UserDetailState()) {
    usersRepository = RepositoryProvider.of(context);

    on<UserDetailsLoaded>(_onUserDetailsLoaded);
  }

  Future<void> _onUserDetailsLoaded(
    UserDetailsLoaded event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(state.copyWith(detailsLoader: EntityStatus.loading));

    try {
      User user = await usersRepository.getUserById(userId);
      emit(state.copyWith(user: user, detailsLoader: EntityStatus.success));
    } catch (e) {
      emit(state.copyWith(detailsLoader: EntityStatus.failure, message: "Failed to get user details"));
    }
  }
}
