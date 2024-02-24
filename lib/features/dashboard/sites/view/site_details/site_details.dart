import '/common_libraries.dart';
import 'widget/widget.dart';

class SiteDetailsView extends StatelessWidget {
  final String siteId;
  const SiteDetailsView({
    super.key,
    required this.siteId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SiteDetailsBloc(context, siteId),
      child: SiteDetailWidget(
        siteId: siteId,
      ),
    );
  }
}

class SiteDetailWidget extends StatefulWidget {
  final String? siteId;
  const SiteDetailWidget({
    super.key,
    this.siteId,
  });

  @override
  State<StatefulWidget> createState() => _SiteDetailWidgetState();
}

class _SiteDetailWidgetState extends State<SiteDetailWidget> {
  static String pageLabel = AppStrings.pageTitleProject;

  Map<String, Widget> get tabItems => widget.siteId != null
      ? {
          'Projects': TabProjectView(widget.siteId!, "Projects"),
          'Companies': TabCompaniesView(widget.siteId!, "Companies"),
          'Users': TabUsersView(widget.siteId!, "Users"),
          'Templates': TabTemplatesView(widget.siteId!, "Templates"),
        }
      : {};

  @override
  void initState() {
    context.read<SiteDetailsBloc>().add(SiteDetailsLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
      builder: (context, state) {
        final themeData = Theme.of(context);
        return DetailsEntityTemplate(
            label: pageLabel,
            id: widget.siteId,
            iconData: FontAwesomeIcons.bacon,
            crudStatus: state.status,
            tabItems: tabItems,
            onTabClick: (index) async {
              return true;
            },
            screenName: 'Sites',
            screenNameOne: 'Site / ',
            screenNameTwo: 'Site Detail',
            child: state.sites == null
                ? const Center(child: Loader())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: inset16,
                        child: Text(
                          state.sites!.name!,
                          style:
                              subMenuTitle.copyWith(color: themeData.textColor),
                        ),
                      ),
                      CustomBottomBorderContainer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: SiteDetailsItemView1()),
                          Expanded(child: SiteDetailsItemView2()),
                          Expanded(child: SiteDetailsItemView3()),
                        ],
                      ),
                    ],
                  ));
      },
    );
  }
}
