import 'package:flutter/services.dart';

import '/common_libraries.dart';

class CustomTextNewField extends StatelessWidget {
  final String? initialValue;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool? isDisabled;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLength;
  final int maxLines;
  final AutovalidateMode autoValidateMode;
  final bool isNumber;
  const CustomTextNewField({
    this.initialValue,
    this.label,
    this.hintText,
    super.key,
    this.validator,
    this.onChanged,
    this.isDisabled,
    this.controller,
    this.maxLength = 10000000,
    this.minLines = 1,
    this.maxLines = 1,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      autovalidateMode: autoValidateMode,
      textAlignVertical: TextAlignVertical.center,
      // controller: controller ?? TextEditingController(text: initialValue),
      controller: controller,
      enabled: !(isDisabled ?? false),
      maxLength: maxLength,
      inputFormatters: textInputFormatters(),
      cursorWidth: 1,
      minLines: minLines,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        counterText: '',
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 43, 43, 43),
        ),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(fontSize: 0.01),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  List<TextInputFormatter> textInputFormatters() {
    List<TextInputFormatter> inputFormatters = [];
    if (maxLines == 1) {
      inputFormatters.add(FilteringTextInputFormatter.singleLineFormatter);
    }
     if (isNumber) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }
    return inputFormatters;
  }
}
