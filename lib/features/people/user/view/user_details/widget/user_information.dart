import '/common_libraries.dart';

class UserInformationView extends StatelessWidget {
  const UserInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state.detailsLoader.isLoading) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Center(
              child: Padding(
                padding: insety30,
                child: const Loader(),
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActionItemInformationItemView(
              label: 'Name',
              content: state.user?.fullName ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Title',
              content: state.user?.title ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Role',
              content: state.user?.roleName ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Email',
              content: state.user?.email ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Phone #',
              content: state.user?.mobileNumber ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Site',
              content: state.user?.siteName ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Created By',
              content: state.user?.createdByUserName ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Created On',
              content: state.user?.createdOn ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Last Updated By',
              content: state.user?.lastModifiedByUserName ?? '',
            ),
            ActionItemInformationItemView(
              label: 'Last Updated On',
              content: state.user?.lastModifiedOn ?? '',
            ),
          ],
        );
      },
    );
  }
}

class ActionItemInformationItemView extends StatelessWidget {
  final String label;
  final String content;
  const ActionItemInformationItemView({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx20y15,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: textSemiBold14.copyWith(
                fontSize: 13,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          spacerx10,
          Expanded(
            flex: 2,
            child: Text(
              content,
              style: textNormal14.copyWith(
                fontSize: 13,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
