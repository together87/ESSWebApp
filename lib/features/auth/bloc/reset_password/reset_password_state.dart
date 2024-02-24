/*
part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final String email;
  final String password;
  final String passwordConfirm;
  final String oldPassword;
  final String message;
  final EntityStatus status;

  final String emailValidationMessage;
  final String oldPasswordValidationMessage;
  final String confirmValidationMessage;
  final bool maxLengthValidated;
  final bool specialCharValidated;
  final bool uppercaseCharValidated;
  const ResetPasswordState({
    this.message = '',
    this.email = '',
    this.password = '',
    this.passwordConfirm = '',
    this.oldPassword = '',
    this.emailValidationMessage = '',
    this.confirmValidationMessage = '',
    this.oldPasswordValidationMessage = '',
    this.maxLengthValidated = false,
    this.specialCharValidated = false,
    this.uppercaseCharValidated = false,
    this.status = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        message,
        status,
        password,
        passwordConfirm,
        oldPassword,
        email,
        oldPasswordValidationMessage,
        emailValidationMessage,
        confirmValidationMessage,
        maxLengthValidated,
        specialCharValidated,
        uppercaseCharValidated,
      ];

  ResetPasswordState copyWith({
    String? email,
    String? password,
    String? passwordConfirm,
    String? oldPassword,
    String? message,
    EntityStatus? status,
    String? emailValidationMessage,
    String? oldPasswordValidationMessage,
    String? confirmValidationMessage,
    bool? maxLengthValidated,
    bool? specialCharValidated,
    bool? uppercaseCharValidated,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      oldPassword: oldPassword ?? this.oldPassword,
      message: message ?? this.message,
      status: status ?? this.status,
      emailValidationMessage:
          emailValidationMessage ?? this.emailValidationMessage,
      oldPasswordValidationMessage:
          oldPasswordValidationMessage ?? this.oldPasswordValidationMessage,
      confirmValidationMessage:
          confirmValidationMessage ?? this.confirmValidationMessage,
      maxLengthValidated: maxLengthValidated ?? this.maxLengthValidated,
      specialCharValidated: specialCharValidated ?? this.specialCharValidated,
      uppercaseCharValidated:
          uppercaseCharValidated ?? this.uppercaseCharValidated,
    );
  }
}
*/
