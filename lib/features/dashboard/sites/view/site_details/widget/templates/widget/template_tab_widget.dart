import '../../../../../../../../common_libraries.dart';
import '../../../../../../../../constants/dimens.dart';

class AvailableTemplatesChangeView extends StatefulWidget {
  final String title;
  const AvailableTemplatesChangeView({required this.title, super.key});

  @override
  State<AvailableTemplatesChangeView> createState() => _AvailableTemplatesChangeViewState();
}

class _AvailableTemplatesChangeViewState extends State<AvailableTemplatesChangeView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          SizedBox(height: 400, child: TabBarView(controller: _tabController, children: const [AssociatedTemplates(), AvailableTemplates()]))
        ],
      );
    });
  }
}

class AssociatedTemplates extends StatefulWidget {
  const AssociatedTemplates({super.key});

  @override
  State<AssociatedTemplates> createState() => _AssociatedTemplatesState();
}

class _AssociatedTemplatesState extends State<AssociatedTemplates> {
  List<Information> templateInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    templateInformationList = [
      Information(content: "Hygiene and Food Supply Audit"),
      Information(content: "Parking anti freeze conditions"),
      Information(content: "Signage and guidance audit"),
      Information(
        content: "Storage facility Fire Hazard Audit",
      ),
      Information(content: "Lab Hygiene and Waste Disposal Audit"),
      Information(
        content: "HVAC and Environment Audit",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        for (final template in templateInformationList)
          CustomBottomBorderContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomSwitch(
                  switchValue: template.isStatus,
                  onChanged: (value) {
                    setState(() {
                      template.isStatus = value;
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
                    template.content!,
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

class AvailableTemplates extends StatefulWidget {
  const AvailableTemplates({super.key});

  @override
  State<AvailableTemplates> createState() => _AvailableTemplatesState();
}

class _AvailableTemplatesState extends State<AvailableTemplates> {
  TextEditingController searchController = TextEditingController();
  List<Information> templateInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    templateInformationList = [
      Information(content: "Hygiene and Food Supply Audit"),
      Information(content: "Parking anti freeze conditions"),
      Information(content: "Signage and guidance audit"),
      Information(
        content: "Storage facility Fire Hazard Audit",
      ),
      Information(content: "Lab Hygiene and Waste Disposal Audit"),
      Information(
        content: "HVAC and Environment Audit",
      ),
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
          for (final template in templateInformationList)
            CustomBottomBorderContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomSwitch(
                    switchValue: template.isStatus,
                    onChanged: (value) {
                      setState(() {
                        template.isStatus = value;
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
                      template.content!,
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
