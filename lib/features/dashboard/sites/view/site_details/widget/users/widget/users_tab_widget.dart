import '../../../../../../../../common_libraries.dart';

class AvailableUserChangeView extends StatefulWidget {
  final String title;
  const AvailableUserChangeView({required this.title, super.key});

  @override
  State<AvailableUserChangeView> createState() => _AvailableUserChangeViewState();
}

class _AvailableUserChangeViewState extends State<AvailableUserChangeView> with TickerProviderStateMixin {
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
        SizedBox(height: 400, child: TabBarView(controller: _tabController, children: [const AssociatedUsersView(), const AvailableUsersView()]))
      ],
    );
  }
}

class AssociatedUsersView extends StatefulWidget {
  const AssociatedUsersView({super.key});

  @override
  State<AssociatedUsersView> createState() => _AssociatedUsersViewState();
}

class _AssociatedUsersViewState extends State<AssociatedUsersView> {
  List<Information> usersInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersInformationList = [
      Information(content: "All Aboujoudeh", others: "Safety Professional"),
      Information(content: "Barbara Smart", others: "Global Admin"),
      Information(content: "Carl kitteridge", others: "Site Amid"),
      Information(content: "Harry Berg", others: "Safety Professional"),
      Information(content: "Nora Eddington", others: "CM Safefy Rep"),
      Information(content: "Oscar Peterman", others: "Contractor Safety Rep"),
      Information(content: "Peter Perrine", others: "Construction Operations"),
      Information(content: "Rusty Abner", others: "Safety Professional"),
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
              for (final user in usersInformationList)
                CustomBottomBorderContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomSwitch(
                        switchValue: user.isStatus,
                        onChanged: (value) {
                          setState(() {
                            user.isStatus = value;
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
                          user.content!,
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

class AvailableUsersView extends StatefulWidget {
  const AvailableUsersView({super.key});

  @override
  State<AvailableUsersView> createState() => _AvailableUsersViewState();
}

class _AvailableUsersViewState extends State<AvailableUsersView> {
  TextEditingController editingController = TextEditingController();

  List<Information> usersInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersInformationList = [
      Information(content: "All Aboujoudeh", others: "Safety Professional"),
      Information(content: "Barbara Smart", others: "Global Admin"),
      Information(content: "Carl kitteridge", others: "Site Amid"),
      Information(content: "Harry Berg", others: "Safety Professional"),
      Information(content: "Nora Eddington", others: "CM Safefy Rep"),
      Information(content: "Oscar Peterman", others: "Contractor Safety Rep"),
      Information(content: "Peter Perrine", others: "Construction Operations"),
      Information(content: "Rusty Abner", others: "Safety Professional"),
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
              for (final user in usersInformationList)
                CustomBottomBorderContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomSwitch(
                        switchValue: user.isStatus,
                        onChanged: (value) {
                          setState(() {
                            user.isStatus = value;
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
                          user.content!,
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
