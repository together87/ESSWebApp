/*
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../common_libraries.dart';
import '../../../../data/bloc/bloc.dart';
import '../../data/repository/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final BuildContext context;

  late AuthRepository _authRepository;
  ResetPasswordBloc(this.context) : super(const ResetPasswordState()) {
    _authRepository = context.read();
    on<ResetPasswordReset>(_onResetPasswordReset);
    on<ResetPasswordEmailChanged>(_onResetPasswordEmailChanged);
    on<ResetPasswordPasswordChanged>(_onResetPasswordPasswordChanged);
    on<ResetPasswordOldPasswordChanged>(_onResetPasswordOldPasswordChanged);
    on<ResetPasswordConfirmPasswordChanged>(
        _onResetPasswordConfirmPasswordChanged);
  }

  void _onResetPasswordConfirmPasswordChanged(
    ResetPasswordConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(
      passwordConfirm: event.password,
      confirmValidationMessage: '',
    ));
  }

  void _onResetPasswordOldPasswordChanged(
    ResetPasswordOldPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(
      oldPassword: event.password,
      oldPasswordValidationMessage: '',
    ));
  }

  void _onResetPasswordPasswordChanged(
    ResetPasswordPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(password: event.password));

    emit(state.copyWith(maxLengthValidated: event.password.length >= 8));

    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

    emit(
        state.copyWith(uppercaseCharValidated: regEx.hasMatch(event.password)));

    regEx = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
        "'"
        ']');

    emit(state.copyWith(specialCharValidated: regEx.hasMatch(event.password)));
  }

  void _onResetPasswordEmailChanged(
    ResetPasswordEmailChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(
      email: event.email,
      emailValidationMessage: '',
    ));
  }

  bool _validate(Emitter<ResetPasswordState> emit) {
    bool validated = true;

    if (Validation.isEmpty(state.oldPassword)) {
      emit(state.copyWith(
          oldPasswordValidationMessage:
              FormValidationMessage(fieldName: 'Temporary Password')
                  .requiredMessage));
    }

    // if (!Validation.isEmail(state.email)) {
    //   emit(state.copyWith(
    //       emailValidationMessage:
    //           FormValidationMessage.emailValidationMessage));

    //   validated = false;
    // }

    if (Validation.isEmpty(state.passwordConfirm)) {
      emit(state.copyWith(
          confirmValidationMessage:
              FormValidationMessage(fieldName: 'Confirm Password')
                  .requiredMessage));
    }

    if (!Validation.isEmpty(state.passwordConfirm) &&
        state.password != state.passwordConfirm) {
      emit(state.copyWith(confirmValidationMessage: 'Passwords are not same.'));

      validated = false;
    }

    validated &= state.maxLengthValidated &&
        state.specialCharValidated &&
        state.uppercaseCharValidated;

    return validated;
  }

  Future<void> _onResetPasswordReset(
    ResetPasswordReset event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (!_validate(emit)) {
      return;
    }

    emit(state.copyWith(status: EntityStatus.loading));

    try {
      EntityResponse response =
          await _authRepository.resetPassword(ResetPassword(
        email: state.email,
        oldPassword: state.oldPassword,
        newPassword: state.password,
        confirmNewPassword: state.passwordConfirm,
      ));

      if (response.isSuccess) {
        emit(state.copyWith(
          message: response.message,
          status: EntityStatus.success,
        ));
      }
    } on HttpException catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        message: e.message,
      ));
    }
  }
}
*/
