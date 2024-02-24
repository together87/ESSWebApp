import '../../../data/model/sidebar_item.dart';
import '../../../data/repository/sidebar_repository.dart';
import '/common_libraries.dart';
import 'widgets/criteria.dart';
import 'widgets/sidebar_item.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.selectedItemName,
  });

  final String selectedItemName;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Widget> _buildSidebarItems(
    List<SidebarItemModel> items,
    String selectedItemName,
    bool isSidebarExtended,
  ) {
    List<Widget> subItemWidgets = [];
    for (int i = 0; i < items.length; i++) {
      subItemWidgets.add(
        SidebarItem(
          iconData: items[i].iconData,
          label: items[i].label,
          path: items[i].path,
          selectedItemName: selectedItemName,
          isSidebarExtended: isSidebarExtended,
          subItems: items[i].subItems,
        ),
      );
    }
    return subItemWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (ctx, state) {
            final isSidebarExtended = context.read<ThemeBloc>().state.isExtended(context);
            return Drawer(
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(color: themeData.cardColor),
                child: SingleChildScrollView(
                  padding: insetx8,
                  child: Column(
                    crossAxisAlignment: isSidebarExtended ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: (MediaQuery.of(context).size.width <= 992.0),
                        child: Container(
                          decoration: BoxDecoration(color: themeData.canvasColor),
                          alignment: Alignment.centerRight,
                          height: kToolbarHeight + 16 - 1,
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  if (Scaffold.of(context).isDrawerOpen) {
                                    Scaffold.of(context).closeDrawer();
                                  }
                                },
                                icon: const FaIcon(FontAwesomeIcons.close),
                                color: themeData.textColor,
                                tooltip: 'Close Navigation Menu',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Criteria(
                          isSidebarExtended: isSidebarExtended,
                          label: 'MENU',
                        ),
                      ),
                      ..._buildSidebarItems(
                        SidebarRepository.mainItems,
                        widget.selectedItemName,
                        isSidebarExtended,
                      ),
                      Divider(
                        color: loginBg,
                        thickness: 0.2,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Criteria(
                          isSidebarExtended: isSidebarExtended,
                          label: 'MASTER TEMPLATE DATA',
                        ),
                      ),
                      ..._buildSidebarItems(
                        SidebarRepository.administrationItems,
                        widget.selectedItemName,
                        isSidebarExtended,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
