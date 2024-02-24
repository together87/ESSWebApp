import '/common_libraries.dart';

class AssociatedChangeView extends StatefulWidget {
  const AssociatedChangeView({super.key});

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
            Tab(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: themeData.hintColor.withOpacity(0.5), width: 2))), child: const Center(child: Text('Associated Companies')))),
            Tab(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: themeData.hintColor.withOpacity(0.5), width: 2))), child: const Center(child: Text('Available Companies')))),
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

class AssociatedCompaniesView extends StatelessWidget {
  const AssociatedCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              for (final companies in state.companiesList)
                CustomBottomBorderContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomSwitch(
                        switchValue: true,
                        onChanged: (value) {},
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
                          companies,
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

class AvailableCompaniesView extends StatelessWidget {
  const AvailableCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    final themeData = Theme.of(context);
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
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
              for (final companies in state.companiesList)
                CustomBottomBorderContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomSwitch(
                        switchValue: false,
                        onChanged: (value) {},
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
                          companies,
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
