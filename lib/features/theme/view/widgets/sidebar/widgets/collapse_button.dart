import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '/common_libraries.dart';
import '/constants/color.dart';

import '../../../../bloc/theme_bloc.dart';
import '../sidebar_style.dart';

class CollapseButton extends StatefulWidget {
  const CollapseButton({
    super.key,
    required this.isSidebarExtended,
  });

  final bool isSidebarExtended;

  @override
  State<CollapseButton> createState() => _CollapseButtonState();
}

class _CollapseButtonState extends State<CollapseButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: widget.isSidebarExtended
          ? sidebarWidth - 50
          : shrinkSidebarWidth - 45,
      top: 20,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      child: GestureDetector(
        onTap: () {
          if (MediaQuery.of(context).size.width < 1000) {
            Navigator.of(context).pop();
          } else {
            context.read<ThemeBloc>().add(ThemeSidebarItemExtended(
                collapsedItem: UrlUtil.getPath(context)));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lightTeal,
            boxShadow: [
              BoxShadow(
                color: sidebarColor,
                offset: const Offset(1, 1),
              )
            ],
          ),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Icon(
              MediaQuery.of(context).size.width < 1000
                  ? PhosphorIconsRegular.x
                  : PhosphorIconsRegular.arrowsLeftRight,
              size: 16,
              weight: 400,
              color: sidebarColor,
            ),
          ),
        ),
      ),
    );
  }
}
