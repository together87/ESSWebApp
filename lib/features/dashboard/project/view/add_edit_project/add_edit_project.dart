import '/common_libraries.dart';
import 'widget/widget.dart';

class AddEditProjectView extends StatelessWidget {
  final String? projectId;
  const AddEditProjectView({
    super.key,
    this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditProjectBloc(context),
      child: AddEditProjectWidget(
        projectId: projectId,
      ),
    );
  }
}

class AddEditProjectWidget extends StatefulWidget {
  final String? projectId;
  const AddEditProjectWidget({
    super.key,
    this.projectId,
  });

  @override
  State<AddEditProjectWidget> createState() => _AddEditProjectWidgetState();
}

class _AddEditProjectWidgetState extends State<AddEditProjectWidget> {
  late AddEditProjectBloc addEditProjectBloc;
  final validationKey = GlobalKey<FormState>();
  static String pageLabel = '';
  static String cancelPath = 'projects';

  @override
  void initState() {
    addEditProjectBloc = context.read()
      ..add(const AddEditProjectDirectorListLoaded(type: "Director"))
      ..add(AddEditProjectSiteListLoaded());

    pageLabel = widget.projectId != null ? AppStrings.subTitleUpdateProject : AppStrings.subTitleCreateProject;

    if (widget.projectId != null) {
      addEditProjectBloc.add(AddEditProjectLoaded(projectId: widget.projectId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditProjectBloc, AddEditProjectState>(
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.projectId,
          iconData: FontAwesomeIcons.bacon,
          cancelPath: cancelPath,
          crudStatus: state.status,
          addEntity: () {
            validationKey.currentState!.validate();
            context.read<AddEditProjectBloc>().add(AddEditProjectAdded());
          },
          editEntity: () {
            validationKey.currentState!.validate();
            context.read<AddEditProjectBloc>().add(AddEditProjectEdited(id: widget.projectId.toString()));
          },
          screenName: widget.projectId != null ? "Edit Project" : "Add Project",
          screenNameOne: 'Project / ',
          screenNameTwo: widget.projectId != null ? "Edit Project" : "Add Project",
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
