import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecosys_safety/data/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../constants/style.dart';
import '../data/bloc/form_dirty/form_dirty_bloc.dart';
import '/common_libraries.dart';
export 'package:awesome_dialog/awesome_dialog.dart';

class CustomAlert {
  final BuildContext context;
  final String? title;
  final double width;
  final String description;
  final String btnOkText;
  final VoidCallback? btnOkOnPress;
  final VoidCallback? btnCancelOnPress;
  final DialogType dialogType;
  final Widget? body;
  CustomAlert({
    required this.context,
    this.title,
    required this.width,
    required this.description,
    required this.btnOkText,
    this.btnOkOnPress,
    this.btnCancelOnPress,
    required this.dialogType,
    this.body,
  });
  Future<dynamic> show() {
    double width = MediaQuery.of(context).size.width;
    return AwesomeDialog(
      context: context,
      width: width > minDesktopWidth ? width / 4 : width / 2.5,
      dialogType: dialogType,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: title,
      body: body,
      dialogBorderRadius: BorderRadius.circular(5),
      desc: description,
      buttonsTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: () => btnOkOnPress!(),
      btnOkText: btnOkText,
      buttonsBorderRadius: BorderRadius.circular(3),
      padding: const EdgeInsets.all(10),
    ).show();
  }

  static checkFormDirty(VoidCallback function, BuildContext context) {
    if (context.read<FormDirtyBloc>().state.isDirty) {
      AwesomeDialog(
        context: context,
        width: MediaQuery.of(context).size.width / 4,
        dialogType: DialogType.question,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Confirm',
        dialogBorderRadius: BorderRadius.circular(5),
        desc: 'Data that was entered will be lost ..... Proceed?',
        buttonsTextStyle: const TextStyle(color: Colors.white),
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          function();
          context
              .read<FormDirtyBloc>()
              .add(const FormDirtyChanged(isDirty: false));
        },
        btnOkText: 'Proceed',
        buttonsBorderRadius: BorderRadius.circular(3),
        padding: const EdgeInsets.all(10),
      ).show();
    } else {
      function();
    }
  }
}
