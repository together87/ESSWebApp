import 'package:ecosys_safety/common_libraries.dart';

class CompanyListView extends StatefulWidget {
  const CompanyListView({super.key});

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CompanyListBloc(context)),
      ],
      child: const CompanyListWidget(),
    );
  }
}

class CompanyListWidget extends StatefulWidget {
  const CompanyListWidget({super.key});

  @override
  State<CompanyListWidget> createState() => _CompanyListWidgetState();
}

class _CompanyListWidgetState extends State<CompanyListWidget> {
  TextEditingController searchController = TextEditingController();
  late CompanyListBloc bloc;

  static String pageLabel = AppStrings.pageTitleCompany;
  static String path = 'company';
  static String emptyMessage =
      'There are no companies. Please click on New Company to add new project';

  @override
  void initState() {
    context.read<CompanyListBloc>().add(CompanyListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyListBloc, CompanyListState>(
      builder: (context, state) {
        return PublicMasterLayout(
            body: EntityListTemplate(
          label: pageLabel,
          emptyMessage: emptyMessage,
          path: path,
          entities: state.companyList,
          iconData: FontAwesomeIcons.teamspeak,
          textEditingController: searchController,
          crudStatus: state.status,
          screenName: 'Companies',
          screenNameOne: 'Safety / ',
          screenNameTwo: 'Companies',
          onSuffixClicked: () {},
          totalRows: 100,
          onDeleteClick: (selectedId) {
            context
                .read<CompanyListBloc>()
                .add(CompanyDeleteClicked(id: selectedId));
          },
        ));
      },
      listener: (context, state) {
        if (state.deleteStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            title: state.title,
            content: state.message,
          ).showNotification();
        }
        if (state.deleteStatus.isFailure) {
          CustomNotification(
            context: context,
            title: state.title,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      //listenWhen: (previous, current) => previous.status != current.status,
    );
  }
}
