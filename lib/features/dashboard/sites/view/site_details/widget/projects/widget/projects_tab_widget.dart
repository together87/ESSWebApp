import '../../../../../../../../common_libraries.dart';
import '/constants/dimens.dart';

class ProjectsTabListWidget extends StatefulWidget {
  final String title;
  const ProjectsTabListWidget({
    required this.title,
    super.key,
  });

  @override
  State<ProjectsTabListWidget> createState() => _ProjectsTabListState();
}

class _ProjectsTabListState extends State<ProjectsTabListWidget> with TickerProviderStateMixin {
  List<Information> projectInformationList = [];

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectInformationList = [
      Information(content: 'Artemis Research Center - Cryogenic Lab'),
      Information(content: 'Artemis Research Center - Freezer Facility'),
      Information(content: 'New HVAC Install Project'),
      Information(content: 'Light poles install'),
    ];
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            labelPadding: const EdgeInsets.all(0),
            controller: _tabController,
            labelStyle: textSemiBold12.copyWith(color: primaryColor, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
            unselectedLabelStyle: textSemiBold12.copyWith(color: themeData.textColor, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
            tabs: <Widget>[
              Tab(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: themeData.hintColor.withOpacity(0.5), width: 2))), child: Center(child: Text('Associated ${widget.title}')))),
              Tab(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: themeData.hintColor.withOpacity(0.5), width: 2))), child: Center(child: Text('Available ${widget.title}')))),
            ],
            indicatorColor: primaryColor,
            indicatorWeight: 0.1,
            automaticIndicatorColorAdjustment: false,
            isScrollable: false,
            dividerColor: primaryColor,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: primaryColor),
            ),
          ),
          SizedBox(height: 400, child: TabBarView(controller: _tabController, children: [const AssociatedProject(), const AvailableProject()]))
        ],
      );
    });
  }
}

class AssociatedProject extends StatefulWidget {
  const AssociatedProject({super.key});

  @override
  State<AssociatedProject> createState() => _AssociatedProjectState();
}

class _AssociatedProjectState extends State<AssociatedProject> {
  List<Information> projectInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectInformationList = [
      Information(content: 'Artemis Research Center - Cryogenic Lab'),
      Information(content: 'Artemis Research Center - Freezer Facility'),
      Information(content: 'New HVAC Install Project'),
      Information(content: 'Light poles install'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        for (final project in projectInformationList)
          CustomBottomBorderContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomSwitch(
                  switchValue: project.isStatus,
                  onChanged: (value) {
                    setState(() {
                      project.isStatus = value;
                    });
                  },
                  onlySwitch: true,
                  active: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    "Associated",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: sitesSubMenuTitle5.copyWith(
                      fontWeight: FontWeight.w600,
                      color: themeData.textColor,
                      fontSize: 13,
                    ),
                  ),
                ),
                spacerx100,
                Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    project.content!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: sitesSubMenuTitle5.copyWith(color: themeData.textColor, fontWeight: FontWeight.w500, fontSize: 13, fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class AvailableProject extends StatefulWidget {
  const AvailableProject({super.key});

  @override
  State<AvailableProject> createState() => _AvailableProjectState();
}

class _AvailableProjectState extends State<AvailableProject> {
  List<Information> projectInformationList = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectInformationList = [
      Information(content: 'Artemis Research Center - Cryogenic Lab'),
      Information(content: 'Artemis Research Center - Freezer Facility'),
      Information(content: 'New HVAC Install Project'),
      Information(content: 'Light poles install'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      child: Column(
        children: [
          CustomBottomBorderContainer(
            padding: insetx20y10.copyWith(left: 10),
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 500,
              child: CustomTextFieldWithIcon(
                  hintText: 'Search companies',
                  suffixWidget: const FaIcon(
                    FontAwesomeIcons.search,
                  ),
                  onSuffixClicked: () {},
                  onChange: (value) {},
                  controller: searchController),
            ),
          ),
          for (final project in projectInformationList)
            CustomBottomBorderContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomSwitch(
                    switchValue: project.isStatus,
                    onChanged: (value) {
                      setState(() {
                        project.isStatus = value;
                      });
                    },
                    onlySwitch: true,
                    active: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      "Associated",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: sitesSubMenuTitle5.copyWith(
                        fontWeight: FontWeight.w600,
                        color: themeData.textColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  spacerx100,
                  Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text(
                      project.content!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: sitesSubMenuTitle5.copyWith(color: themeData.textColor, fontWeight: FontWeight.w500, fontSize: 13, fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
