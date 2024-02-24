import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../data/model/sidebar_item.dart';
import '../sidebar_style.dart';
import '/common_libraries.dart';

class SidebarItem extends StatefulWidget {
  final IconData? iconData;
  final String label;
  final String path;
  final String selectedItemName;

  //final Color color;
  final bool isSidebarExtended;
  final List<SidebarItemModel> subItems;
  final bool isSubItem;

  const SidebarItem({
    Key? key,
    required this.label,
    required this.path,
    required this.selectedItemName,
    required this.isSidebarExtended,
    this.iconData,
    this.subItems = const [],
    this.isSubItem = false,
  }) : super(key: key);

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> with TickerProviderStateMixin {
  bool isHover = false;
  bool isSidebarItemExtended = false;
  CustomPopupMenuController customPopupMenuController = CustomPopupMenuController();
  final tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();

    setState(() {
      isSidebarItemExtended = widget.subItems.map((e) => e.path).contains(
            widget.selectedItemName,
          );
    });
  }

  @override
  void dispose() {
    customPopupMenuController.dispose();
    tooltipController.dispose();
    super.dispose();
  }

  void _showPopupMenu(ThemeState state) {
    if (widget.subItems.isNotEmpty && !widget.isSidebarExtended) {
      customPopupMenuController.showMenu();
    }
  }

  void _hidePopupMenu(ThemeState state) {
    if (widget.subItems.isNotEmpty && !widget.isSidebarExtended) {
      customPopupMenuController.hideMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state.hoveredItemName != widget.label) {
          _hidePopupMenu(state);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPopupMenu(
              controller: customPopupMenuController,
              menuBuilder: () => MouseRegion(
                onExit: (event) {
                  _hidePopupMenu(state);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: sidebarColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildSubItemsMenu(),
                    ],
                  ),
                ),
              ),
              barrierColor: Colors.transparent,
              pressType: PressType.longPress,
              showArrow: false,
              horizontalMargin: shrinkSidebarWidth + 5,
              verticalMargin: -sidebarItemHeight - 30,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (event) {
                  setState(() {
                    isHover = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    isHover = false;
                  });
                },
                child: _buildItemBody(state),
              ),
            ),
            ...(widget.isSidebarExtended && isSidebarItemExtended ? _buildSubItemsMenu() : []),
          ],
        );
      },
    );
  }

  List<Widget> _buildSubItemsMenu() {
    return widget.subItems
        .map(
          (subItem) => SidebarItem(
            iconData: subItem.iconData,
            label: subItem.label,
            path: subItem.path,
            selectedItemName: widget.selectedItemName,
            // color: subItem.color,
            isSidebarExtended: widget.isSidebarExtended,
            isSubItem: true,
          ),
        )
        .toList();
  }

  Widget _buildExtendIcon(ThemeState state) {
    return widget.isSidebarExtended && widget.subItems.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              isSidebarItemExtended ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              //color: isSidebarItemExtended ? widget.color : backgroundColor,
              size: 24,
            ),
          )
        : Container();
  }

  Widget _buildLabel() {
    final themeData = Theme.of(context);
    return widget.isSidebarExtended || widget.isSubItem
        ? Container(
            alignment: Alignment.center,
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.selectedItemName == widget.path ? AppColors.whiteColor : themeData.textColor,
                fontSize: 14,
              ),
            ),
          )
        : Container();
  }

  void _onClick() {
    if (context.read<FormDirtyBloc>().state.isDirty && !widget.path.contains('logout')) {
      CustomAlert(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        title: 'Notification',
        description: 'Data that was entered will be lost ..... Proceed?',
        btnOkText: 'Proceed',
        btnOkOnPress: () => _navigate(),
        btnCancelOnPress: () {},
        dialogType: DialogType.info,
      ).show();
    } else {
      _navigate();
    }
  }

  void _navigate() {
    if (widget.path.contains('logout')) {
      CustomAlert(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        title: 'Confirm',
        description: 'Do you really want to logout?',
        btnOkText: 'Logout',
        btnOkOnPress: () => context.read<AuthBloc>().add(const AuthUnauthenticated()),
        btnCancelOnPress: () {},
        dialogType: DialogType.question,
      ).show();
    } else {
      if (widget.path.isNotEmpty) {
        if ('/${widget.path}' == GoRouter.of(context).location) {
          GoRouter.of(context).go('/${widget.path}/index');
        } else {
          GoRouter.of(context).go('/${widget.path}');
        }
      }

      setState(() {
        isSidebarItemExtended = !isSidebarItemExtended;
      });
    }
    context.read<FormDirtyBloc>().add(const FormDirtyChanged(isDirty: false));
  }

  Widget _buildItemBody(ThemeState state) {
    return GestureDetector(
      onTap: _onClick,
      child: MouseRegion(
        onEnter: (event) {
          if (!widget.isSubItem) {
            context.read<ThemeBloc>().add(
                  ThemeSidebarHovered(hoveredItemName: widget.label),
                );
            _showPopupMenu(state);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.selectedItemName == widget.path
                  ? AppColors.primaryColor
                  : isHover
                      ? Colors.black.withOpacity(0.05)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          height: sidebarItemHeight,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.only(
              left: (widget.isSidebarExtended ? 30 : 17) + (widget.isSubItem ? 0 : 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.isSubItem
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Icon(
                              widget.iconData,
                              color: widget.selectedItemName == widget.path ? AppColors.whiteColor : AppColors.yellow,
                              size: 13,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              widget.iconData,
                              color: AppColors.yellow,
                              size: 16,
                            ),
                          ),
                    _buildLabel(),
                  ],
                ),
                _buildExtendIcon(state)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
