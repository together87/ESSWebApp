import '/common_libraries.dart';
import 'widget/widget.dart';

class AddEditUserView extends StatelessWidget {
  final String? userId;
  const AddEditUserView({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditUsersBloc(context),
      child: AddEditUserWidget(
        userId: userId,
      ),
    );
  }
}

class AddEditUserWidget extends StatefulWidget {
  final String? userId;
  const AddEditUserWidget({
    super.key,
    this.userId,
  });

  @override
  State<AddEditUserWidget> createState() => _AddEditUserWidgetState();
}

class _AddEditUserWidgetState extends State<AddEditUserWidget> {
  late AddEditUsersBloc addEditUsersBloc;
  final validationKey = GlobalKey<FormState>();
  static String pageLabel = '';
  static String cancelPath = 'users';

  @override
  void initState() {
    addEditUsersBloc = context.read()
      ..add(AddEditUserSiteListLoaded())
      ..add(AddEditUserRoleListLoaded());

    pageLabel = widget.userId != null ? AppStrings.subTitleUpdateUsers : AppStrings.subTitleCreateUsers;

    if (widget.userId != null) {
      addEditUsersBloc.add(AddEditUserLoaded(userId: widget.userId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditUsersBloc, AddEditUsersState>(
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.userId,
          iconData: FontAwesomeIcons.userGroup,
          cancelPath: cancelPath,
          crudStatus: state.status,
          addEntity: () {
            validationKey.currentState!.validate();
            context.read<AddEditUsersBloc>().add(const AddEditUserAdded());
          },
          editEntity: () {
            validationKey.currentState!.validate();
            context.read<AddEditUsersBloc>().add(AddEditUserEdited(userId: int.parse(widget.userId!)));
          },
          screenName: widget.userId != null ? "Edit User" : "Add User",
          screenNameOne: 'User / ',
          screenNameTwo: widget.userId != null ? "Edit User" : "Add User",
          child: AddEditView(validationKey),
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
          context.go('/users');
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
