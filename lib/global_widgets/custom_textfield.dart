import 'package:flutter/services.dart';

import '/common_libraries.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool? isDisabled;
  final bool? isBorderStatus;
  final TextEditingController? controller;
  final IconData? suffixIconData;
  final Color suffixIconColor;
  final Color suffixIconBackgroundColor;
  final double iconSize;
  final VoidCallback? onSuffixIconClick;
  final double? height;
  final Widget? suffixWidget;
  final int? minLines;
  final int? maxLength;
  final int maxLines;
  final EdgeInsets contentPadding;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final TextInputType? inputType;
  final bool isAmount;
  final bool isName;
  final bool allowNegative;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validator;
  final int? textLength;
  final TextStyle? textStyle;
  final TextAlignVertical? textAlignVertical;
  final InputDecoration? decoration;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.labelText,
      this.initialValue,
      this.onChanged,
      this.onEditingComplete,
      this.isDisabled,
      this.isBorderStatus = true,
      this.controller,
      this.suffixIconData,
      this.suffixIconColor = const Color(0xff0c81ff),
      this.suffixIconBackgroundColor = const Color(0xffeeeeee),
      this.iconSize = 20,
      this.onSuffixIconClick,
      this.height = 80,
      this.suffixWidget,
      this.maxLength = 10000000,
      this.minLines = 1,
      this.maxLines = 1,
      this.contentPadding = const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      this.onSubmitted,
      this.focusNode,
      this.onTap,
      this.inputType,
      this.isAmount = false,
      this.isName = false,
      this.allowNegative = false,
      this.autoValidateMode,
      this.textAlignVertical,
      this.decoration,
      this.validator,
      this.textLength = 50,
      this.textStyle = const TextStyle(
        fontSize: 16,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
      )});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return SizedBox(
      child: TextFormField(
        key: widget.key,
        initialValue: widget.initialValue,
        keyboardType: widget.inputType,
        controller: widget.controller,
        focusNode: widget.focusNode,
        enabled: !(widget.isDisabled ?? false),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        maxLength: widget.maxLength,
        inputFormatters: textInputFormatters(),
        style: widget.textStyle,
        onTap: widget.onTap,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          contentPadding: widget.contentPadding,
          //errorStyle: const TextStyle(fontSize: 0.01),
          // To avoid text box's height change, due to error message, setting font size 0.01
          border: OutlineInputBorder(
            borderRadius: widget.isBorderStatus!
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.isBorderStatus!
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: widget.isBorderStatus!
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.isBorderStatus!
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
            borderSide: BorderSide(
              color: grey,
            ),
          ),
          counterText: '',
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.isBorderStatus!
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
            borderSide: BorderSide(
              color: grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.isBorderStatus!
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
            borderSide: BorderSide(
              color: grey,
            ),
          ),
          suffixIcon: widget.suffixIconData == null
              ? widget.suffixWidget == null
                  ? null
                  : GestureDetector(
                      // onTap: () => widget.onSuffixIconClick!(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: widget.isBorderStatus!
                              ? const BorderRadius.all(Radius.circular(5))
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 1,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: widget.suffixWidget,
                      ),
                    )
              : GestureDetector(
                  onTap: () => widget.onSuffixIconClick!(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: widget.isBorderStatus!
                          ? const BorderRadius.all(Radius.circular(5))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Icon(
                      widget.suffixIconData,
                      color: widget.suffixIconColor,
                      size: widget.iconSize,
                    ),
                  ),
                ),
        ),
        cursorColor: darkTeal,
        cursorWidth: 1,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        validator: widget.validator,
        autovalidateMode: widget.autoValidateMode,
        textAlignVertical: widget.textAlignVertical,
      ),
    );
  }

  List<TextInputFormatter> textInputFormatters() {
    List<TextInputFormatter> inputFormatters = [];

    if (widget.maxLines == 1) {
      inputFormatters.add(FilteringTextInputFormatter.singleLineFormatter);
    }

    inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength ?? 50));

    if (widget.allowNegative) {
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp("^-?\\d*")));
    } else if (widget.isAmount) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    } else if (widget.isName) {
      inputFormatters.add(FilteringTextInputFormatter.deny(RegExp(r'[0-9]')));
    }

    return inputFormatters;
  }
}
