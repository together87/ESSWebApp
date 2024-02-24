import '/common_libraries.dart';

class DetailsEntityTemplate extends StatefulWidget {
  final String label;
  final IconData iconData;
  final String? id;
  final Widget child;
  final EntityStatus crudStatus;
  final Map<String, Widget> tabItems;
  final double tabWidth;
  final String? view;
  final Future<bool> Function(int)? onTabClick;
  final String screenName;
  final String screenNameOne;
  final String screenNameTwo;

  const DetailsEntityTemplate({
    super.key,
    required this.label,
    required this.iconData,
    this.id,
    this.tabItems = const {},
    this.tabWidth = 300,
    this.view,
    required this.child,
    this.crudStatus = EntityStatus.initial,
    this.onTabClick,
    required this.screenName,
    required this.screenNameOne,
    required this.screenNameTwo,
  });

  @override
  State<DetailsEntityTemplate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailsEntityTemplate> {
  late int selectedTabIndex = 0;
  String token = '';

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) => previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return PublicMasterLayout(
          body: Padding(
            padding: inset16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(backClick: goToList, backButtonShow: true, iconData: widget.iconData, screenName: widget.screenName, screenNameOne: widget.screenNameOne, screenNameTwo: widget.screenNameTwo),
                spacery10,
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.child,
                          if (widget.tabItems.isNotEmpty)
                            Padding(
                              padding: inset16,
                              child: Text(
                                "Details Section",
                                style: subMenuTitle.copyWith(color: themeData.textColor),
                              ),
                            ),
                          if (widget.tabItems.isNotEmpty) _buildTab(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  goToList() {
    String location = GoRouter.of(context).location;
    location = location.replaceRange(location.indexOf('show'), null, '');
    GoRouter.of(context).go(location);
  }

  Widget _buildTab() {
    return CustomTabBar(
      activeIndex: selectedTabIndex,
      tabs: widget.tabItems,
      onTabClick: (index, previous) async {
        if (widget.onTabClick != null) {
          return await widget.onTabClick!(index);
        } else {
          return true;
        }
      },
    );
  }
}
