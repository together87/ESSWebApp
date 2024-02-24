import '../../../../../../common_libraries.dart';

class SitesPage extends StatefulWidget {
  const SitesPage({super.key});
  @override
  State<StatefulWidget> createState() => _SitesPageState();
}

class _SitesPageState extends State<SitesPage> {
  TextEditingController searchController = TextEditingController();
  late SitesBloc sitesBloc;

  static String pageLabel = AppStrings.sites;
  static String path = 'sites';
  static String emptyMessage = 'There are no sites. Please click on New Sites to add new sites';

  @override
  void initState() {
    sitesBloc = context.read<SitesBloc>();
    sitesBloc.add(SitesListFiltered());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SitesBloc, SitesState>(
      builder: (context, state) {
        return EntityListTemplate(
          label: pageLabel,
          emptyMessage: emptyMessage,
          path: path,
          entities: state.sitesList,
          iconData: FontAwesomeIcons.bacon,
          textEditingController: searchController,
          crudStatus: state.crudStatus,
          screenName: 'Site',
          screenNameOne: 'Safety / ',
          screenNameTwo: 'Site',
          onSuffixClicked: () {},
          totalRows: 100,
          onDeleteClick: (selectedId) {
            context.read<SitesBloc>().add(SiteDelete(siteId: selectedId));
          },
        );
      },
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          if (state.status == EntityStatus.success) {
            CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              title: 'Success',
              content: state.message,
            ).showNotification();
          } else if (state.status == EntityStatus.failure) {
            CustomNotification(
              context: context,
              title: "Failure",
              notifyType: NotifyType.error,
              content: state.message,
            ).showNotification();
          }
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
    );
  }
}
