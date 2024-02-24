import '/common_libraries.dart';

class AssociatedChangeView extends StatefulWidget {
  final String title;
  const AssociatedChangeView({required this.title, super.key});

  @override
  State<AssociatedChangeView> createState() => _AssociatedChangeViewState();
}

class _AssociatedChangeViewState extends State<AssociatedChangeView> with TickerProviderStateMixin {
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
    return Column(
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
        SizedBox(height: 400, child: TabBarView(controller: _tabController, children: [const AssociatedCompaniesView(), const AvailableCompaniesView()]))
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class AssociatedCompaniesView extends StatefulWidget {
  const AssociatedCompaniesView({super.key});

  @override
  State<AssociatedCompaniesView> createState() => _AssociatedCompaniesViewState();
}

class _AssociatedCompaniesViewState extends State<AssociatedCompaniesView> {
  List<Information> companyInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyInformationList = [
      Information(content: "Power Tools& Roofing LLC"),
      Information(content: "Galelio Weather Services Inc"),
      Information(content: "Geprgoia Concrete"),
      Information(content: "Kashi Inc"),
      Information(content: "Logistic and Manpower Placements LLC"),
      Information(content: "Maxwell and Gather Inc"),
      Information(content: "Runkin Associstes Glassworks Inc"),
      Information(content: "zodiac Builders Inc"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              for (final companies in companyInformationList)
                CustomBottomBorderContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomSwitch(
                        switchValue: companies.isStatus,
                        onChanged: (value) {
                          setState(() {
                            companies.isStatus = value;
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
                          companies.content!,
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
      },
    );
  }
}

class AvailableCompaniesView extends StatefulWidget {
  const AvailableCompaniesView({super.key});

  @override
  State<AvailableCompaniesView> createState() => _AvailableCompaniesViewState();
}

class _AvailableCompaniesViewState extends State<AvailableCompaniesView> {
  TextEditingController editingController = TextEditingController();

  List<Information> companyInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyInformationList = [
      Information(content: "Power Tools& Roofing LLC"),
      Information(content: "Galelio Weather Services Inc"),
      Information(content: "Geprgoia Concrete"),
      Information(content: "Kashi Inc"),
      Information(content: "Logistic and Manpower Placements LLC"),
      Information(content: "Maxwell and Gather Inc"),
      Information(content: "Runkin Associstes Glassworks Inc"),
      Information(content: "zodiac Builders Inc"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomBottomBorderContainer(
                padding: inset20,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 600,
                  child: CustomTextFieldWithIcon(
                      hintText: 'Search companies',
                      suffixWidget: const FaIcon(
                        FontAwesomeIcons.search,
                      ),
                      onSuffixClicked: () {},
                      onChange: (value) {},
                      controller: editingController),
                ),
              ),
              for (final companies in companyInformationList)
                CustomBottomBorderContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomSwitch(
                        switchValue: companies.isStatus,
                        onChanged: (value) {
                          setState(() {
                            companies.isStatus = value;
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
                          companies.content!,
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
      },
    );
  }
}
