import '/common_libraries.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({super.key});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProjectListBloc(context)),
      ],
      child: const ProjectListWidget(),
    );
  }
}

class ProjectListWidget extends StatefulWidget {
  const ProjectListWidget({super.key});

  @override
  State<ProjectListWidget> createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  TextEditingController searchController = TextEditingController();
  late ProjectListBloc projectsBloc;

  static String pageLabel = AppStrings.pageTitleProject;
  static String path = 'projects';
  static String emptyMessage = 'There are no project. Please click on New Project to add new project';

  @override
  void initState() {
    projectsBloc = context.read<ProjectListBloc>();
    projectsBloc.add(const ProjectListFiltered());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectListBloc, ProjectListState>(
      builder: (context, state) {
        return PublicMasterLayout(
          body: EntityListTemplate(
            label: pageLabel,
            emptyMessage: emptyMessage,
            path: path,
            entities: state.projectList,
            iconData: FontAwesomeIcons.bacon,
            textEditingController: searchController,
            crudStatus: state.projectCrud,
            screenName: 'Projects',
            screenNameOne: 'Safety / ',
            screenNameTwo: 'Projects',
            onSuffixClicked: () {},
            totalRows: 100,
            onDeleteClick: (selectedId) {
              context.read<ProjectListBloc>().add(ProjectDelete(projectId: selectedId));
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
