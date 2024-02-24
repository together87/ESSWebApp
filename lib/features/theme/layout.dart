import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/theme/view/widgets/sidebar/sidebar.dart';
import 'package:ecosys_safety/features/theme/view/widgets/sidebar/sidebar_style.dart';
import 'package:ecosys_safety/features/theme/view/widgets/sidebar/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_sidebar_theme.dart';

class Layout extends StatefulWidget {
  const Layout({
    super.key,
    required this.body,
    required this.selectedItemName,
  });

  final Widget body;
  final String selectedItemName;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      body: widget.body,
      selectedItemName: widget.selectedItemName,
    );
  }
}

class LayoutWidget extends StatefulWidget {
  final Widget body;
  final String selectedItemName;

  const LayoutWidget({
    super.key,
    required this.body,
    required this.selectedItemName,
  });

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  late ScrollController _scrollController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late AuthBloc _authBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    scaffoldKey.currentState?.openDrawer();
    _authBloc = context.read<AuthBloc>();
    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc.state.authUser == null || _authBloc.state is AuthUnauthenticateSuccess) {
      GoRouter.of(context).go('/login');
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final drawer = (mediaQueryData.size.width <= 992.0 ? Sidebar(selectedItemName: widget.selectedItemName) : null);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, stateTheme) {
      return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticateSuccess) {
            if (state.statusCode == 401) {
              CustomNotification(
                context: context,
                notifyType: NotifyType.info,
                content: 'Session has expired',
              ).showNotification();
            }
            GoRouter.of(context).go('/login');
          }
        },
        builder: (context, state) => state.authUser == null
            ? const LoginView()
            : LayoutBuilder(
                builder: (context, constraints) => InactivityDetectWidget(
                  onShouldNavigate: (p0) {
                    _authBloc.add(const AuthUnauthenticated());
                    CustomNotification(
                      context: context,
                      notifyType: NotifyType.info,
                      content: 'Session has expired',
                    ).showNotification();
                  },
                  child: Scaffold(
                    key: scaffoldKey,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(64),
                      child: AppBar(
                        elevation: 3,
                        automaticallyImplyLeading: (drawer != null),
                        centerTitle: mediaQueryData.size.width < 992.0 ? true : false,
                        title: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 70),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 200,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                        iconTheme: themeData.iconTheme,
                        actions: [
                          // GestureDetector(
                          //   onTap: () {
                          //     context.read<ThemeBloc>().add(UpdateTheme(isDarkThemeOn: stateTheme.isDarkThemeOn ? false : true));
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 8),
                          //     child: Icon(
                          //       stateTheme.isDarkThemeOn ? Icons.dark_mode : Icons.light_mode,
                          //       color: themeData.textColor,
                          //     ),
                          //   ),
                          // ),
                          spacerx30,
                          _username(state.authUser!.name, themeData, context),
                          spacerx30,
                        ],
                      ),
                    ),
                    drawer: drawer,
                    backgroundColor: themeData.bgColor,
                    drawerEnableOpenDragGesture: false,
                    drawerScrimColor: Colors.transparent,
                    body: _responsiveBody(context),
                  ),
                ),
              ),
      );
    });
  }

  Widget _responsiveBody(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 992) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(padding: const EdgeInsets.only(bottom: 16 * 1.5), child: widget.body),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Theme.of(context).extension<AppSidebarTheme>()?.sidebarWidth,
            child: Sidebar(selectedItemName: widget.selectedItemName),
          ),
          Expanded(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(padding: const EdgeInsets.only(bottom: 16 * 1.5), child: widget.body),
            ],
          )),
        ],
      );
    }
  }

  Widget _username(String userName, ThemeData themeData, context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: PopupMenuButton(
        tooltip: '',
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        onSelected: (value) {},
        offset: const Offset(0.0, 55),
        itemBuilder: (ctx) => [
          _buildPopupMenuItemTitle('Activity', context),
          _buildPopupMenuItem('chat', Options.search.index, context),
          _buildPopupMenuItem('Recover password', Options.upload.index, context),
          _buildPopupMenuItemTitle('My Account', context),
          _buildPopupMenuItem('Setting', Options.copy.index, context),
          _buildPopupMenuItem('Messages', Options.exit.index, context),
          _buildPopupMenuItem('Logs', Options.exit.index, context),
        ],
        child: Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: white,
              backgroundImage: const AssetImage('assets/images/logo.png'),
            ),
            spacerx4,
            Text(userName, style: GoogleFonts.inter(color: themeData.textColor, fontSize: 14, fontWeight: FontWeight.w600)),
            spacerx4,
            Icon(
              Icons.keyboard_arrow_down,
              color: themeData.textColor,
              size: 16,
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position, context) {
    return PopupMenuItem(
      value: position,
      onTap: () {
        if (title == 'Setting') {
          GoRouter.of(context).go("RouteUri.profile");
        } else if (title == 'chat') {
          GoRouter.of(context).go("RouteUri.chatscreen");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                spacerx8,
                Text(title),
              ],
            ),
            Visibility(
              visible: title == 'chat' || title == 'Messages' || title == 'Setting',
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: title == 'chat'
                      ? AppColors.buttonInfoColor
                      : title == 'Setting'
                          ? AppColors.tabscreenbutton
                          : AppColors.errorcolor,
                ),
                child: Text(
                  title == 'chat'
                      ? '8'
                      : title == 'Setting'
                          ? 'New'
                          : '512',
                  style: const TextStyle(fontSize: 11, color: AppColors.whiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItemTitle(String title, context) {
    return PopupMenuItem(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Theme.of(context).canvasColor),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
