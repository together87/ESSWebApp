import '/common_libraries.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserListBloc(context)),
      ],
      child: const UsersListWidget(),
    );
  }
}

class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  TextEditingController searchController = TextEditingController();
  late UserListBloc projectsBloc;

  static String pageLabel = AppStrings.pageTitleUser;
  static String path = 'users';
  static String emptyMessage = 'There are no users. Please click on New User to add new user';

  @override
  void initState() {
    projectsBloc = context.read<UserListBloc>();
    projectsBloc.add(const UserListFiltered());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      builder: (context, state) {
        return PublicMasterLayout(
          body: EntityListTemplate(
            label: pageLabel,
            emptyMessage: emptyMessage,
            path: path,
            entities: state.userList,
            iconData: FontAwesomeIcons.userGroup,
            textEditingController: searchController,
            crudStatus: state.userCrud,
            screenName: 'User',
            screenNameOne: 'People / ',
            screenNameTwo: 'User',
            onSuffixClicked: () {},
            totalRows: 40,
            onDeleteClick: (selectedId) {
              context.read<UserListBloc>().add(UserDetailUserDeleted(userId: selectedId));
            },
          ),
        );
      },
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            title: state.title,
            content: state.message,
          ).showNotification();
          context.go('/projects');
        }
        if (state.status.isFailure) {
          CustomNotification(
            context: context,
            title: state.title,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
    );
  }
}
