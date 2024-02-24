import 'package:ecosys_safety/features/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../common_libraries.dart';
import '../../../../../../constants/dimens.dart';
import '../../../../../../global_widgets/sized_box.dart';

enum Options { activity, search, upload, copy, exit }

class Header extends StatefulWidget {
  final String userName;
  final bool isSidebarExtended;

  const Header({
    super.key,
    required this.userName,
    required this.isSidebarExtended,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _username(widget.userName, themeData, context),
    );
  }

  Widget _username(String userName, ThemeData themeData, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        tooltip: '',
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        onSelected: (value) {
          // popupMenuItemIndex = value;
        },
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
              radius: 20,
              backgroundColor: white,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            buildSizedboxW(kTextPadding),
            Text(userName, style: GoogleFonts.inter(color: themeData.textColor, fontSize: 14, fontWeight: FontWeight.w600)),
            Icon(
              Icons.keyboard_arrow_down,
              color: themeData.textColor,
              size: kDefaultPadding,
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
                buildSizedboxW(kTextPadding * 2),
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
