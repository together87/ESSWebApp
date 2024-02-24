import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomBottomBorderContainer extends Container {
  final Color? backgroundColor;
  CustomBottomBorderContainer({
    super.key,
    super.padding,
    super.child,
    super.alignment,
    super.margin,
    this.backgroundColor,
    super.foregroundDecoration,
  }) : super(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: greyBorder,
                width: 1,
              ),
            ),
            color: backgroundColor,
          ),
        );
}
