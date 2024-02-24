import '/common_libraries.dart';
import 'widget/widget.dart';

class ProjectDetailsView extends StatelessWidget {
  final String projectId;
  const ProjectDetailsView({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectDetailsBloc(context, projectId),
      child: ProjectDetailsWidget(
        projectId: projectId,
      ),
    );
  }
}

class ProjectDetailsWidget extends StatefulWidget {
  final String? projectId;
  const ProjectDetailsWidget({
    super.key,
    this.projectId,
  });

  @override
  State<ProjectDetailsWidget> createState() => _ProjectDetailsWidgetState();
}

class _ProjectDetailsWidgetState extends State<ProjectDetailsWidget> {
  late ProjectDetailsBloc projectDetailsBloc;
  static String pageLabel = AppStrings.pageTitleProject;

  Map<String, Widget> get tabItems => widget.projectId != null
      ? {
          'Companies': TabCompaniesView(widget.projectId),
          'Project Documentation': TabProjectDocumentationView(widget.projectId),
          'Supporting Documentation': TabSupportingDocumentationView(widget.projectId),
        }
      : {};

  @override
  void initState() {
    context.read<ProjectDetailsBloc>().add(ProjectDetailsLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectDetailsBloc, ProjectDetailsState>(
      builder: (context, state) {
        return DetailsEntityTemplate(
          label: pageLabel,
          id: widget.projectId,
          iconData: FontAwesomeIcons.bacon,
          crudStatus: state.status,
          tabItems: tabItems,
          onTabClick: (index) async {
            return true;
          },
          screenName: 'Projects',
          screenNameOne: 'Project / ',
          screenNameTwo: 'Project Detail',
          child: state.project == null
              ? const Center(child: Loader())
              : const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: ProjectDetailsItemView1()),
                    Expanded(child: ProjectDetailsItemView2()),
                    Expanded(child: ProjectDetailsItemView3()),
                  ],
                ),
        );
      },
      listener: (context, state) {},
      listenWhen: (previous, current) => previous.status != current.status,
    );
  }
}
