import 'package:ecosys_safety/features/people/user/view/user_details/widget/user_information.dart';

import '/common_libraries.dart';

class UserDetailView extends StatelessWidget {
  final String userId;
  const UserDetailView({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailBloc(context, userId),
      child: UserDetailWidget(userId: userId),
    );
  }
}

class UserDetailWidget extends StatefulWidget {
  final String userId;
  const UserDetailWidget({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  static String pageLabel = AppStrings.pageTitleProject;
  static String backPath = 'users';

  @override
  void initState() {
    context.read<UserDetailBloc>().add(UserDetailsLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        return DetailsEntityTemplate(
          label: pageLabel,
          id: widget.userId,
          iconData: FontAwesomeIcons.userGroup,
          crudStatus: state.status,
          screenName: 'User Detail',
          screenNameOne: 'User / ',
          screenNameTwo: 'User Detail',
          child: const UserInformationView(),
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
