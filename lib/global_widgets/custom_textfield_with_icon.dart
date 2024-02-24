import 'package:flutter/material.dart';

import 'global_widget.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final Widget suffixWidget;
  final VoidCallback onSuffixClicked;
  final ValueChanged<String> onChange;
  final TextEditingController controller;

  const CustomTextFieldWithIcon({
    super.key,
    required this.hintText,
    required this.suffixWidget,
    required this.onSuffixClicked,
    required this.onChange,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      onChanged: (val) {
        onChange(val);
      },
      onSubmitted: (_) => onSuffixClicked(),
      controller: controller,
      suffixWidget: suffixWidget,
      onSuffixIconClick: onSuffixClicked,
      contentPadding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
